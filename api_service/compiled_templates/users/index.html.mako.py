# -*- encoding:utf-8 -*-
from mako import runtime, filters, cache
UNDEFINED = runtime.UNDEFINED
__M_dict_builtin = dict
__M_locals_builtin = locals
_magic_number = 8
_modified_time = 1347433397.974303
_enable_loop = True
_template_filename = 'views/users/index.html.mako'
_template_uri = 'users/index.html.mako'
_source_encoding = 'utf-8'
_exports = []


def render_body(context,**pageargs):
    __M_caller = context.caller_stack._push_frame()
    try:
        __M_locals = __M_dict_builtin(pageargs=pageargs)
        url_for = context.get('url_for', UNDEFINED)
        result = context.get('result', UNDEFINED)
        __M_writer = context.writer()
        # SOURCE LINE 1
        __M_writer(u'<h1>Listing users</h1>\n\n<table>\n  <tr>\n    <th>id</th>\n    <th>first_name</th>\n    <th>last_name</th>\n    <th>photo_path</th>\n    <th>email</th>\n    <th>photo_path</th>\n    <th></th>\n    <th></th>\n    <th></th>\n  </tr>\n  \n')
        # SOURCE LINE 16
        users = result 
        
        __M_locals_builtin_stored = __M_locals_builtin()
        __M_locals.update(__M_dict_builtin([(__M_key, __M_locals_builtin_stored[__M_key]) for __M_key in ['users'] if __M_key in __M_locals_builtin_stored]))
        __M_writer(u'\n  \n')
        # SOURCE LINE 18
        for user in users:
            # SOURCE LINE 19
            __M_writer(u'    <tr>\n        <td>')
            # SOURCE LINE 20
            __M_writer(unicode(user['id']))
            __M_writer(u'</td>\n        <td>')
            # SOURCE LINE 21
            __M_writer(unicode(user['first_name']))
            __M_writer(u'</td>\n        <td>')
            # SOURCE LINE 22
            __M_writer(unicode(user['last_name']))
            __M_writer(u'</td>\n        <td>')
            # SOURCE LINE 23
            __M_writer(unicode(user['photo_path']))
            __M_writer(u'</td>\n        <td>')
            # SOURCE LINE 24
            __M_writer(unicode(user['email']))
            __M_writer(u'</td>\n        <td>')
            # SOURCE LINE 25
            __M_writer(unicode(user['photo_path']))
            __M_writer(u'</td>\n        <td><a href="')
            # SOURCE LINE 26
            __M_writer(unicode(url_for('users.view_single_user', userid=user['id'])))
            __M_writer(u'">show</a></td>\n        <td><a href="')
            # SOURCE LINE 27
            __M_writer(unicode(url_for('users.edit_user', userid=user['id'])))
            __M_writer(u'">edit</a></td>\n        <td><a href="')
            # SOURCE LINE 28
            __M_writer(unicode(url_for('users.delete_user', userid=user['id'])))
            __M_writer(u'">destroy</a></td>\n    </tr>\n')
        # SOURCE LINE 31
        __M_writer(u'\n</table>\n\n<br />\n\n<a href="')
        # SOURCE LINE 36
        __M_writer(unicode(url_for('users.create')))
        __M_writer(u'">New</a>')
        return ''
    finally:
        context.caller_stack._pop_frame()


