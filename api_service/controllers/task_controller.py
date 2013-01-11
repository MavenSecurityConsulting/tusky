import logging
import os

from flask import request
from flask import Blueprint
from flask import g
from flask import redirect
from flask import url_for

from utilities import remove_unwanted_keyvalue
from utilities import method_not_supported_message
from models.task import Task
# a custom render method i wrote
from render import render
from dbinit import engine

log = logging.getLogger(__name__)

mod = Blueprint('tasks', __name__)

templates_folder = "tasks"

@mod.route("/owner/<owner_id>", methods=["get", "post"])
def view(owner_id):
    template = os.path.join(templates_folder, "index.html.mako")

    if owner_id:
        log.info("Getting all tasks for user %s."%owner_id)
        tasks = Task.query.filter_by(owner_id=owner_id).all()
    
        all_tasks = []
    
        for task in tasks:
            task_dict_repr = task.__dict__
            task_dict_repr = remove_unwanted_keyvalue(task_dict_repr)
            all_tasks.append(task_dict_repr)
        
        return render(result=dict(all_tasks=all_tasks), template=template)
    else:
        log.info("No owner id specified. Returning empty.")
        
        return render(result=[], template=template)
        
@mod.route("/", methods=["post"])
def post_new_task():
    log.info("Received new task data: %s"%request.form)

    new_task = Task(request.form['title'].strip(), request.form['description'].strip(),
                              int(request.form['status']),request.form['owner_id'])
    engine.session.add(new_task)
    engine.session.commit()

    log.info("New task created.")

    ## redirect to self to get all tasks
    return redirect(url_for('tasks.view_single_task', taskid=new_task.id))
        
@mod.route("/<taskid>", methods=["get", "post"])
def view_single_task(taskid):
    log.info("Getting data for task: %s"%taskid)
    
    template = os.path.join(templates_folder, "show.html.mako")
    
    if request.method.lower() == "get":
        taskid = int(taskid)
        task = Task.query.filter_by(id=taskid).first()
    
        task = task.__dict__
        task = remove_unwanted_keyvalue(task)
    
        return render(result=task, template=template, error_msg=None)

        
@mod.route("/<taskid>/delete", methods=["get"])
def delete_task(taskid):    
    pass

@mod.route("/<taskid>/edit", methods=["get"])
def edit_task(taskid):
    pass
    
@mod.route("/create", methods=["get"])
def create():
    pass
    
