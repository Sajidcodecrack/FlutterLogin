from flask import Flask, request
from flask_restx import Api, Resource, fields
from flask_pymongo import PyMongo
from flask_bcrypt import Bcrypt
from flask_cors import CORS
from email_validator import validate_email, EmailNotValidError
import jwt
import datetime

# Flask setup
app = Flask(__name__)
CORS(app)
bcrypt = Bcrypt(app)
app.config["MONGO_URI"] = "mongodb://localhost:27017/Flutter"
app.config["SECRET_KEY"] = "YOUR_SECRET_KEY"  # Change in production!

# MongoDB setup
mongo = PyMongo(app)
try:
    mongo.db.list_collection_names()
    print("✅ MongoDB is connected")
except Exception as e:
    print("❌ MongoDB connection failed:", e)

# Swagger setup
api = Api(app, version='1.0', title='Flutter Auth API', description='Login & Registration API')

ns = api.namespace('auth', description='Authentication operations')

# Swagger models
register_model = api.model('Register', {
    'name': fields.String(required=True, description='Full Name'),
    'email': fields.String(required=True, description='Email Address'),
    'password': fields.String(required=True, description='Password'),
})

login_model = api.model('Login', {
    'email': fields.String(required=True, description='Email Address'),
    'password': fields.String(required=True, description='Password'),
})

# Registration endpoint
@ns.route('/register')
class Register(Resource):
    @ns.expect(register_model)
    def post(self):
        data = request.get_json()
        name = data.get('name')
        email = data.get('email')
        password = data.get('password')

        # Validate email
        try:
            validate_email(email)
        except EmailNotValidError as e:
            return {"message": str(e)}, 400

        # Check if user exists
        if mongo.db.users.find_one({"email": email}):
            return {"message": "User already exists"}, 400

        # Hash password
        hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')

        # Insert into MongoDB
        user_id = mongo.db.users.insert_one({
            "name": name,
            "email": email,
            "password": hashed_password,
            "created_at": datetime.datetime.utcnow()
        }).inserted_id

        return {"message": "Registration successful", "user_id": str(user_id)}, 201

# Login endpoint
@ns.route('/login')
class Login(Resource):
    @ns.expect(login_model)
    def post(self):
        data = request.get_json()
        email = data.get('email')
        password = data.get('password')

        user = mongo.db.users.find_one({"email": email})
        if not user:
            return {"message": "Invalid email or password"}, 401

        if not bcrypt.check_password_hash(user['password'], password):
            return {"message": "Invalid email or password"}, 401

        # Generate JWT token
        token = jwt.encode({
            "user_id": str(user['_id']),
            "exp": datetime.datetime.utcnow() + datetime.timedelta(hours=24)
        }, app.config['SECRET_KEY'], algorithm="HS256")

        return {"message": "Login successful", "token": token}, 200
# app.py
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)  # listen on all interfaces

