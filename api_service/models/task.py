from dbinit import engine

class Task(engine.Model):
    __tablename__ =  'task'
    
    id = engine.Column('id', engine.Integer, primary_key=True, nullable=False, autoincrement=True)
    title = engine.Column('title', engine.String(256), nullable=False)
    description = engine.Column('description', engine.String(), nullable=False)
    status = engine.Column('status', engine.Integer, nullable=False)
    owner_id = engine.Column('owner_id', engine.Integer, engine.ForeignKey('user.id'), nullable=False)

    def __init__(self, title, description, status, owner_id):
        self.title = title
        self.description = description
        self.status = status
        self.owner_id = owner_id
        
    def __repr__(self):
        return "<Task(id='%s', title='%s', description='%s', status='%s', owner_id='%s')>"%(self.id, 
                    self.title, self.description, self.status, self.owner_id)