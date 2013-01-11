import logging
import json

from flask import abort
from flask import url_for
from flask import request
from flask import Response

from mako.lookup import TemplateLookup

log = logging.getLogger(__name__)

mako_lookup = TemplateLookup(
        directories=['views'],
        module_directory='compiled_templates',

        input_encoding = 'utf-8',
        output_encoding = 'utf-8'
        )
        
def render(result=None, template=None, **kw):
    """
    1. Replacement for the flask render_template which uses mako instead
    2. Determines the best return type (json or html) based on the mimetype
    3. "result" is a python dictionary/list. If best return type is json, it will be converted to
        json string. Else it will be passed along to the template as a python dictionary
        for parsing.
    """
    
    mimetype = request.accept_mimetypes
    
    best = None
    
    best = mimetype.best_match([
                'application/json',
                'application/xhtml+xml',
                'text/html',
    ])
    
    # To prevent sending JSON to */* client when text/html is available
    if mimetype.quality(best) < mimetype.quality('text/html'):
        best = 'text/html'
        
    if best is None:
        best = 'application/json'
        
    log.info("Determined %s to be best return type."%best)
    
    if best in ('application/json',):
        log.info("Return type is determined to be json.")
        
        # either there is a valid result
        if result is not None:
            log.info(json.dumps(result))
            return Response(json.dumps(result), mimetype="application/json")
        
        # of there must be an error in the operation with an error message    
        elif "error_msg" in kw:
            log.info(json.dumps(kw["error_msg"]))
            return Response(json.dumps(kw["error_msg"]), mimetype="application/json")
            
        
    
    elif best in ('application/xhtml+xml', 'text/html'):
        # if best is determined to be html but no template is specfied, it shall be an error
        if template is None:
            log.debug("Return type is determined to be html but no template specified. Aborting program...")
            abort(500, 'No template specified.')
            
        else:
            return mako_lookup.get_template(template).render(result=result, request=request, url_for=url_for,
                                                        **kw)
        
    else:
        log.debug("Unknown content-type: %s. Aborting program..."%best)
        abort(500, 'Unknown content-type "{0}"'.format(best))