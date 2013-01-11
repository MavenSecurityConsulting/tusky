import json
import logging
import datetime

from flask import Flask
from flask.ext.sqlalchemy import SQLAlchemy

from dbinit import app

logging.basicConfig(format='%(asctime)s[%(levelname)s] %(module)s %(funcName)s:    %(message)s', 
                        level=logging.DEBUG)
log = logging.getLogger(__name__)

HOST = "127.0.0.1"
PORT = 5000
DEBUG_MODE = True

@app.route("/")
def index():
    return "<h1>Index</h1>"
    
def attach_blueprints_to_app():
    from controllers import user_controller
    app.register_blueprint(user_controller.mod, url_prefix='/%s' % user_controller.mod.name)
    
    from controllers import task_controller
    app.register_blueprint(task_controller.mod, url_prefix='/%s' % task_controller.mod.name)

if __name__ == '__main__':
    attach_blueprints_to_app()
    
    app.run(host=HOST, port=PORT, debug=DEBUG_MODE)
