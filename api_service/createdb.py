"""
This file should be only called once. To its just to create the initial database.
"""

from dbinit import engine
from models.user import User
from models.task import Task

engine.create_all()