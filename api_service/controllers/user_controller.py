import logging
import os

from flask import request
from flask import Blueprint
from flask import g
from flask import redirect
from flask import url_for

from utilities import remove_unwanted_keyvalue
from utilities import method_not_supported_message
from models.user import User
# a custom render method i wrote
from render import render
from dbinit import engine

log = logging.getLogger(__name__)

mod = Blueprint('users', __name__)

templates_folder = "users"

@mod.route("/", methods=["get", "post"])
def view():
    template = os.path.join(templates_folder, "index.html.mako")
    
    if request.method.lower() == "get":
        users = User.query.all()
        
        all_users = []
        
        for user in users:
            user_dict_repr = user.__dict__
            user_dict_repr = remove_unwanted_keyvalue(user_dict_repr)
            all_users.append(user_dict_repr)
            
        return render(result=all_users, template=template)
        
    elif request.method.lower() == "post":
        log.info("Received new user data: %s"%request.form)
        
        # Todo:
        # 2. Need to salt password
        # 3. Have not implemented photo upload. (Might not be implementing)
        user_with_email = User.query.filter_by(email=request.form['email']).first()
        if user_with_email is None:
            new_user = User(request.form['first_name'].strip(), request.form['last_name'].strip(),
                                      request.form['email'].strip(), request.form['password'].strip())
            engine.session.add(new_user)
            engine.session.commit()
        
            log.info("New user created.")
        
            return redirect(url_for('users.view_single_user', userid=new_user.id))
            
        else:
            # email is already registered. throw an error
            return redirect(url_for('users.view_single_user', userid="email_registered"))

    else:
        return method_not_supported_message(request.method.lower())
        
@mod.route("/<userid>", methods=["get", "post"])
def view_single_user(userid):
    template = os.path.join(templates_folder, "show.html.mako")
    
    if request.method.lower() == "get":
        try:
            userid = int(userid)
            user = User.query.filter_by(id=userid).first()
        
            user = user.__dict__
            user = remove_unwanted_keyvalue(user)
        
            return render(result=user, template=template, error_msg=None)
            
        except ValueError:
            if userid == "email_registered":
                error_msg = dict(error="Email already registered!")
                
            elif userid == "email_pw_wrong":
                error_msg = dict(error="Email/password combination is wrong.")
            
            return render(template=template, error_msg=error_msg)

    elif request.method.lower() == "post":
        log.info("Received new user data to edit: %s"%request.form)
         
        user = User.query.filter_by(id=userid).first()
        
        for attr in user.__dict__.keys(): 
            if attr != "id" and attr in request.form:
                setattr(user, attr, request.form[attr])
        
        engine.session.commit()
        log.info("User edited") 
        
        return redirect(url_for('users.view_single_user', userid=userid))
        
    else:
        return method_not_supported_message(request.method.lower())
        
@mod.route("/<userid>/delete", methods=["get"])
def delete_user(userid):    
    if request.method.lower() == "get":
        user_to_delete = User.query.filter_by(id=userid).first()
        engine.session.delete(user_to_delete)
        engine.session.commit()
        
        return redirect(url_for('users.view'))
        
    else:
        return method_not_supported_message(request.method.lower())

@mod.route("/<userid>/edit", methods=["get"])
def edit_user(userid):
    template = os.path.join(templates_folder, "edit.html.mako")
    
    if request.method.lower() == "get":
        user = User.query.filter_by(id=userid).first()
        
        user = user.__dict__
        user = remove_unwanted_keyvalue(user)
        
        return render(result=user, template=template)
        
    else:
        return method_not_supported_message(request.method.lower())
    
@mod.route("/create", methods=["get"])
def create():
    template = os.path.join(templates_folder, "new.html.mako")
    
    if request.method.lower() == "get":
        return render(template=template)
        
    else:
        return method_not_supported_message(request.method.lower())
        
@mod.route("/authenticate", methods=["post"])
def authenticate():
    template = os.path.join(templates_folder, "new.html.mako")

    if request.method.lower() == "post":
        email = request.form["email"]
        password = request.form["password"]
        user = User.query.filter_by(email=email).filter_by(password=password).first() 
        
        if user:
            log.info("Authentication successful")
            return redirect(url_for('users.view_single_user', userid=user.id))
            
        else:
            # email/pwd combination is wrong
            return redirect(url_for('users.view_single_user', userid="email_pw_wrong"))

    else:
        return method_not_supported_message(request.method.lower())
    
