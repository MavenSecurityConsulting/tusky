%if hasattr(next, 'body'):
    ${next.body()}
%endif

<% 
# both edit and create will include this form. if its a create result (and hence user) will be None
user = result
%>

<form method="post" action="${url_for('users.view') if user is None else url_for('users.view_single_user', userid=user['id'])}">
    <div>
        %if user is None:
            <b>id</b>&nbsp;<input type="text" name="id" id=="id" disabled="disabled">
        %else:
            <b>id</b>&nbsp;<input type="text" name="id" id=="id" value="${user['id']}" readonly="readonly">
        %endif
    </div>
    <div>
        <b>first_name</b>&nbsp;<input type="text" name="first_name" id=="first_name" value="${user['first_name'] if user is not None else ''}">
    </div>
    <div>
        <b>last_name</b>&nbsp;<input type="text" name="last_name" id=="last_name" value="${user['last_name'] if user is not None else ''}">
    </div>
    <div>
        <b>email</b>&nbsp;<input type="text" name="email" id=="email" value="${user['email'] if user is not None else ''}">
    </div>
    <div>
        <b>password</b>&nbsp;<input type="password" name="password" id=="password" value="${user['password'] if user is not None else ''}">
    </div>
    <div>
        <b>photo_path</b>&nbsp;<input type="text" name="photo_path" id=="photo_path" value="${user['photo_path'] or "" if user is not None else ''}">
    </div>
    <div>
        <input type="submit" value="Submit">
    </div>
</form>

<a href="${url_for('users.view')}">Back</a> 