from flask import Blueprint, request, jsonify
from models.user_model import create_user, find_user_by_email, verify_password
from utils.validators import is_valid_email, is_strong_password
from utils.auth_helper import generate_jwt

auth_bp = Blueprint("auth", __name__)

# Registration
@auth_bp.route("/register", methods=["POST"])
def register():
    data = request.json
    full_name = data.get("full_name")
    email = data.get("email")
    password = data.get("password")

    if not full_name or not email or not password:
        return jsonify({"error": "All fields are required"}), 400

    if not is_valid_email(email):
        return jsonify({"error": "Invalid email address"}), 400

    if not is_strong_password(password):
        return jsonify({"error": "Password must be at least 8 chars, include uppercase, lowercase, and number"}), 400

    if find_user_by_email(email):
        return jsonify({"error": "Email already registered"}), 400

    create_user(email, password, full_name)
    return jsonify({"message": "Registration successful"}), 201

# Login
@auth_bp.route("/login", methods=["POST"])
def login():
    data = request.json
    email = data.get("email")
    password = data.get("password")

    if not email or not password:
        return jsonify({"error": "Email and password required"}), 400

    user = find_user_by_email(email)
    if not user or not verify_password(user["password"], password):
        return jsonify({"error": "Invalid email or password"}), 401

    token = generate_jwt(email)
    return jsonify({"token": token, "full_name": user["full_name"]}), 200
