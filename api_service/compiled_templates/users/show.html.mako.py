# -*- encoding:utf-8 -*-
from mako import runtime, filters, cache
UNDEFINED = runtime.UNDEFINED
__M_dict_builtin = dict
__M_locals_builtin = locals
_magic_number = 8
_modified_time = 1348463304.890147
_enable_loop = True
_template_filename = 'views/users/show.html.mako'
_template_uri = 'users/show.html.mako'
_source_encoding = 'utf-8'
_exports = []


def render_body(context,**pageargs):
    __M_caller = context.caller_stack._push_frame()
    try:
        __M_locals = __M_dict_builtin(pageargs=pageargs)
        url_for = context.get('url_for', UNDEFINED)
        error_msg = context.get('error_msg', UNDEFINED)
        result = context.get('result', UNDEFINED)
        __M_writer = context.writer()
        # SOURCE LINE 1
        if error_msg is not None:
            # SOURCE LINE 2
            __M_writer(u'    ')
            __M_writer(unicode(error_msg["error"]))
            __M_writer(u'<br>\n')
        # SOURCE LINE 4
        __M_writer(u'\n')
        # SOURCE LINE 5
        user = result 
        
        __M_locals_builtin_stored = __M_locals_builtin()
        __M_locals.update(__M_dict_builtin([(__M_key, __M_locals_builtin_stored[__M_key]) for __M_key in ['user'] if __M_key in __M_locals_builtin_stored]))
        __M_writer(u' \n')
        # SOURCE LINE 6
        if user is not None:
            # SOURCE LINE 7
            __M_writer(u'    <div>\n        <b>id</b>&nbsp;')
            # SOURCE LINE 8
            __M_writer(unicode(user['id']))
            __M_writer(u'\n    </div>\n    <div>\n        <b>first_name</b>&nbsp;')
            # SOURCE LINE 11
            __M_writer(unicode(user['first_name']))
            __M_writer(u'\n    </div>\n    <div>\n        <b>last_name</b>&nbsp;')
            # SOURCE LINE 14
            __M_writer(unicode(user['last_name']))
            __M_writer(u'\n    </div>\n    <div>\n        <b>email</b>&nbsp;')
            # SOURCE LINE 17
            __M_writer(unicode(user['email']))
            __M_writer(u'\n    </div>\n    <div>\n        <b>photo_path</b>&nbsp;')
            # SOURCE LINE 20
            __M_writer(unicode(user['photo_path']))
            __M_writer(u'\n    </div> \n\n    <a href="')
            # SOURCE LINE 23
            __M_writer(unicode(url_for('users.edit_user', userid=user['id'])))
            __M_writer(u'">Edit</a> | \n')
        # SOURCE LINE 25
        __M_writer(u'<a href="')
        __M_writer(unicode(url_for('users.view')))
        __M_writer(u'">Back</a>\n')
        return ''
    finally:
        context.caller_stack._pop_frame()


