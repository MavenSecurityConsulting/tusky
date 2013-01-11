# -*- encoding:utf-8 -*-
from mako import runtime, filters, cache
UNDEFINED = runtime.UNDEFINED
__M_dict_builtin = dict
__M_locals_builtin = locals
_magic_number = 8
_modified_time = 1355212825.443407
_enable_loop = True
_template_filename = 'views/tasks/show.html.mako'
_template_uri = 'tasks/show.html.mako'
_source_encoding = 'utf-8'
_exports = []


def render_body(context,**pageargs):
    __M_caller = context.caller_stack._push_frame()
    try:
        __M_locals = __M_dict_builtin(pageargs=pageargs)
        __M_writer = context.writer()
        # SOURCE LINE 1
        __M_writer(u'<!-- shows attributes of a single task line by line -->\n\n<!-- link to edit this task --> | <!-- link Back (to show all tasks) -->\n')
        return ''
    finally:
        context.caller_stack._pop_frame()


