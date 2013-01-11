<h1>Listing tasks</h1>

<table>
  <tr>
    <th>id</th>
    <th>title</th>
    <th>description</th>
    <th>status</th>
    <th>owner_id</th>
    <th></th>
    <th></th>
    <th></th>
  </tr>
  
<% tasks = result["all_tasks"] %>

%for task in tasks:
  <tr>
      <td>${task['id']}</td>
      <td>${task["title"]}</td>
      <td>${task["description"]}</td>
      <td>${task["status"]}</td>
      <td>${task["owner_id"]}</td>
      <td><a href="${url_for('tasks.view_single_task', taskid=task['id'])}">show</a></td>
      <td><a href="${url_for('tasks.edit_task', taskid=task['id'])}">edit</a></td>
      <td><a href="${url_for('tasks.delete_task', taskid=task['id'])}">destroy</a></td>
  </tr>
%endfor

</table>

<br />

<a href="${url_for('tasks.create')}">New</a>