# -*- encoding:utf-8 -*-
from mako import runtime, filters, cache
UNDEFINED = runtime.UNDEFINED
__M_dict_builtin = dict
__M_locals_builtin = locals
_magic_number = 8
_modified_time = 1355212872.070912
_enable_loop = True
_template_filename = 'views/tasks/index.html.mako'
_template_uri = 'tasks/index.html.mako'
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
        __M_writer(u'<h1>Listing tasks</h1>\n\n<table>\n  <tr>\n    <th>id</th>\n    <th>title</th>\n    <th>description</th>\n    <th>status</th>\n    <th>owner_id</th>\n    <th></th>\n    <th></th>\n    <th></th>\n  </tr>\n  \n')
        # SOURCE LINE 15
        tasks = result["all_tasks"] 
        
        __M_locals_builtin_stored = __M_locals_builtin()
        __M_locals.update(__M_dict_builtin([(__M_key, __M_locals_builtin_stored[__M_key]) for __M_key in ['tasks'] if __M_key in __M_locals_builtin_stored]))
        __M_writer(u'\n\n')
        # SOURCE LINE 17
        for task in tasks:
            # SOURCE LINE 18
            __M_writer(u'  <tr>\n      <td>')
            # SOURCE LINE 19
            __M_writer(unicode(task['id']))
            __M_writer(u'</td>\n      <td>')
            # SOURCE LINE 20
            __M_writer(unicode(task["title"]))
            __M_writer(u'</td>\n      <td>')
            # SOURCE LINE 21
            __M_writer(unicode(task["description"]))
            __M_writer(u'</td>\n      <td>')
            # SOURCE LINE 22
            __M_writer(unicode(task["status"]))
            __M_writer(u'</td>\n      <td>')
            # SOURCE LINE 23
            __M_writer(unicode(task["owner_id"]))
            __M_writer(u'</td>\n      <td><a href="')
            # SOURCE LINE 24
            __M_writer(unicode(url_for('tasks.view_single_task', taskid=task['id'])))
            __M_writer(u'">show</a></td>\n      <td><a href="')
            # SOURCE LINE 25
            __M_writer(unicode(url_for('tasks.edit_task', taskid=task['id'])))
            __M_writer(u'">edit</a></td>\n      <td><a href="')
            # SOURCE LINE 26
            __M_writer(unicode(url_for('tasks.delete_task', taskid=task['id'])))
            __M_writer(u'">destroy</a></td>\n  </tr>\n')
        # SOURCE LINE 29
        __M_writer(u'\n</table>\n\n<br />\n\n<a href="')
        # SOURCE LINE 34
        __M_writer(unicode(url_for('tasks.create')))
        __M_writer(u'">New</a>')
        return ''
    finally:
        context.caller_stack._pop_frame()


