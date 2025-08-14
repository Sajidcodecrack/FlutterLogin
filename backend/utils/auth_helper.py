import jwt
from datetime import datetime, timedelta
from config import Config

def generate_jwt(email):
    payload = {
        "email": email,
        "exp": datetime.utcnow() + timedelta(days=1)
    }
    token = jwt.encode(payload, Config.SECRET_KEY, algorithm="HS256")
    return token

def verify_jwt(token):
    try:
        payload = jwt.decode(token, Config.SECRET_KEY, algorithms=["HS256"])
        return payload["email"]
    except (jwt.ExpiredSignatureError, jwt.InvalidTokenError):
        return None
