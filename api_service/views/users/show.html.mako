%if error_msg is not None:
    ${error_msg["error"]}<br>
%endif

<% user = result %> 
%if user is not None:
    <div>
        <b>id</b>&nbsp;${user['id']}
    </div>
    <div>
        <b>first_name</b>&nbsp;${user['first_name']}
    </div>
    <div>
        <b>last_name</b>&nbsp;${user['last_name']}
    </div>
    <div>
        <b>email</b>&nbsp;${user['email']}
    </div>
    <div>
        <b>photo_path</b>&nbsp;${user['photo_path']}
    </div> 

    <a href="${url_for('users.edit_user', userid=user['id'])}">Edit</a> | 
%endif
<a href="${url_for('users.view')}">Back</a>
