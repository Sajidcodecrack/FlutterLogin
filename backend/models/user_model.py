from flask_pymongo import PyMongo
from flask_bcrypt import Bcrypt

mongo = PyMongo()
bcrypt = Bcrypt()

def create_user(email, password, full_name):
    hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')
    user = {
        "email": email.lower(),
        "password": hashed_password,
        "full_name": full_name
    }
    return mongo.db.users.insert_one(user)

def find_user_by_email(email):
    return mongo.db.users.find_one({"email": email.lower()})

def verify_password(hashed_password, password):
    return bcrypt.check_password_hash(hashed_password, password)
