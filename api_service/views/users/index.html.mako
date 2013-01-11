<h1>Listing users</h1>

<table>
  <tr>
    <th>id</th>
    <th>first_name</th>
    <th>last_name</th>
    <th>photo_path</th>
    <th>email</th>
    <th>photo_path</th>
    <th></th>
    <th></th>
    <th></th>
  </tr>
  
<% users = result %>
  
%for user in users:
    <tr>
        <td>${user['id']}</td>
        <td>${user['first_name']}</td>
        <td>${user['last_name']}</td>
        <td>${user['photo_path']}</td>
        <td>${user['email']}</td>
        <td>${user['photo_path']}</td>
        <td><a href="${url_for('users.view_single_user', userid=user['id'])}">show</a></td>
        <td><a href="${url_for('users.edit_user', userid=user['id'])}">edit</a></td>
        <td><a href="${url_for('users.delete_user', userid=user['id'])}">destroy</a></td>
    </tr>
%endfor

</table>

<br />

<a href="${url_for('users.create')}">New</a>