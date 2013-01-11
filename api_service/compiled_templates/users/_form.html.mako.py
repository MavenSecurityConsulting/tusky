# -*- encoding:utf-8 -*-
from mako import runtime, filters, cache
UNDEFINED = runtime.UNDEFINED
__M_dict_builtin = dict
__M_locals_builtin = locals
_magic_number = 8
_modified_time = 1347512311.718802
_enable_loop = True
_template_filename = u'views/users/_form.html.mako'
_template_uri = u'users/_form.html.mako'
_source_encoding = 'utf-8'
_exports = []


def render_body(context,**pageargs):
    __M_caller = context.caller_stack._push_frame()
    try:
        __M_locals = __M_dict_builtin(pageargs=pageargs)
        url_for = context.get('url_for', UNDEFINED)
        result = context.get('result', UNDEFINED)
        hasattr = context.get('hasattr', UNDEFINED)
        next = context.get('next', UNDEFINED)
        __M_writer = context.writer()
        # SOURCE LINE 1
        if hasattr(next, 'body'):
            # SOURCE LINE 2
            __M_writer(u'    ')
            __M_writer(unicode(next.body()))
            __M_writer(u'\n')
        # SOURCE LINE 4
        __M_writer(u'\n')
        # SOURCE LINE 5
 
# both edit and create will include this form. if its a create result (and hence user) will be None
        user = result
        
        
        __M_locals_builtin_stored = __M_locals_builtin()
        __M_locals.update(__M_dict_builtin([(__M_key, __M_locals_builtin_stored[__M_key]) for __M_key in ['user'] if __M_key in __M_locals_builtin_stored]))
        # SOURCE LINE 8
        __M_writer(u'\n\n<form method="post" action="')
        # SOURCE LINE 10
        __M_writer(unicode(url_for('users.view') if user is None else url_for('users.view_single_user', userid=user['id'])))
        __M_writer(u'">\n    <div>\n')
        # SOURCE LINE 12
        if user is None:
            # SOURCE LINE 13
            __M_writer(u'            <b>id</b>&nbsp;<input type="text" name="id" id=="id" disabled="disabled">\n')
            # SOURCE LINE 14
        else:
            # SOURCE LINE 15
            __M_writer(u'            <b>id</b>&nbsp;<input type="text" name="id" id=="id" value="')
            __M_writer(unicode(user['id']))
            __M_writer(u'" readonly="readonly">\n')
        # SOURCE LINE 17
        __M_writer(u'    </div>\n    <div>\n        <b>first_name</b>&nbsp;<input type="text" name="first_name" id=="first_name" value="')
        # SOURCE LINE 19
        __M_writer(unicode(user['first_name'] if user is not None else ''))
        __M_writer(u'">\n    </div>\n    <div>\n        <b>last_name</b>&nbsp;<input type="text" name="last_name" id=="last_name" value="')
        # SOURCE LINE 22
        __M_writer(unicode(user['last_name'] if user is not None else ''))
        __M_writer(u'">\n    </div>\n    <div>\n        <b>email</b>&nbsp;<input type="text" name="email" id=="email" value="')
        # SOURCE LINE 25
        __M_writer(unicode(user['email'] if user is not None else ''))
        __M_writer(u'">\n    </div>\n    <div>\n        <b>password</b>&nbsp;<input type="password" name="password" id=="password" value="')
        # SOURCE LINE 28
        __M_writer(unicode(user['password'] if user is not None else ''))
        __M_writer(u'">\n    </div>\n    <div>\n        <b>photo_path</b>&nbsp;<input type="text" name="photo_path" id=="photo_path" value="')
        # SOURCE LINE 31
        __M_writer(unicode(user['photo_path'] or "" if user is not None else ''))
        __M_writer(u'">\n    </div>\n    <div>\n        <input type="submit" value="Submit">\n    </div>\n</form>\n\n<a href="')
        # SOURCE LINE 38
        __M_writer(unicode(url_for('users.view')))
        __M_writer(u'">Back</a> ')
        return ''
    finally:
        context.caller_stack._pop_frame()


