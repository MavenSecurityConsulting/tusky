from dbinit import engine
from models.task import Task

class User(engine.Model):
    __tablename__ =  'user'
    
    id = engine.Column('id', engine.Integer, primary_key=True, nullable=False, autoincrement=True)
    first_name = engine.Column('first_name', engine.String(256), nullable=False)
    last_name = engine.Column('last_name', engine.String(256), nullable=False)
    photo_path = engine.Column('photo_path', engine.String(256), nullable=True)
    email = engine.Column('email', engine.String(256), nullable=False)
    password = engine.Column('password', engine.String(256), nullable=False)
    
    tasks = engine.relationship("Task", backref="user", lazy="dynamic")  
    
    def __init__(self, first_name, last_name, email, password, photo_path=""):
        self.first_name = first_name
        self.last_name = last_name
        self.photo_path = photo_path
        self.email = email
        self.password = password
        
    def __repr__(self):
        return "<User(id='%s', email='%s', first_name='%s', last_name='%s', photo_path='%s')>"%(self.id, 
                    self.email, self.first_name, self.last_name, self.photo_path)
