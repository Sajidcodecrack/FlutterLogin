
# **Login & Registration System (Flutter + Flask + MongoDB)**

## **Project Overview**

This project demonstrates a fully functional **Login & Registration System** built using **Flutter** for the frontend, **Flask** for the backend, and **MongoDB** for the database. It provides secure authentication through **JWT (JSON Web Tokens)** and allows users to register, log in, and manage their authentication.

### **Tech Stack**

* **Frontend**: Flutter
* **Backend**: Flask
* **Database**: MongoDB
* **Authentication**: JWT (JSON Web Tokens)
* **Packages**: `http`, `shared_preferences`, `flask-pymongo`, `flask-bcrypt`, `flask-restx`

### **Target Audience**

This system is intended for web and mobile applications, allowing users to **register**, **login**, and be authenticated securely.

---

## **Features**

* **User Registration**: Users can sign up with a name, email, and password.
* **User Login**: After registration, users can log in to their account with email and password.
* **JWT Authentication**: The backend returns a **JWT token** upon successful login.
* **Frontend & Backend**: The Flutter frontend communicates with a Flask API backend, which connects to MongoDB.

---

## **Setup & Installation**

### **Backend Setup (Flask + MongoDB)**

#### **Step 1: Clone the Repository**

Clone the backend repository to your local machine:

```bash
git clone <your-repo-url>
cd backend
```

#### **Step 2: Create and Activate Virtual Environment**

```bash
python -m venv venv
# Activate virtual environment
# Windows
venv\Scripts\activate
# Mac/Linux
source venv/bin/activate
```

#### **Step 3: Install Dependencies**

Install the necessary Python packages:

```bash
pip install -r requirements.txt
```

#### **Step 4: Set Up MongoDB**

* Install and configure **MongoDB** locally or use **MongoDB Atlas**.
* **Database**: `Flutter`
* **Collection**: `users`
* The backend automatically creates the database and collection after the first user registration.

#### **Step 5: Set Up Environment Variables**

Create a `.env` file for sensitive information:

```
MONGO_URI=mongodb://localhost:27017/Flutter
SECRET_KEY=your_secret_key_here
```

#### **Step 6: Run the Backend**

Start the Flask backend:

```bash
python app.py
```

The backend will run on `http://127.0.0.1:5000/`.

#### **Step 7: Test with Postman**

Use **Postman** to test the following endpoints:

* **POST /auth/register**: Register a new user.
* **POST /auth/login**: Login and retrieve a JWT token.

---

### **Frontend Setup (Flutter)**

#### **Step 1: Clone the Flutter Project**

Clone the Flutter project to your local machine:

```bash
git clone <your-repo-url>
cd frontend
```

#### **Step 2: Install Dependencies**

Install the necessary Flutter packages:

```bash
flutter pub get
```

#### **Step 3: Configure Backend URL**

In the `api_service.dart` file, set the correct backend URL for your environment:

```dart
static const String baseUrl = "http://10.0.2.2:5000/auth";  // For Android emulator
```

* **For iOS simulator**: `localhost`
* **For real device**: Use your PC’s IP (e.g., `192.168.x.x:5000`)

#### **Step 4: Run the Flutter App**

Run the Flutter app on your device or emulator:

```bash
flutter run
```

---

## **API Documentation**

### **1. Register (POST /auth/register)**

#### **Request Body**:

```json
{
  "name": "John Doe",
  "email": "john.doe@example.com",
  "password": "password123"
}
```

#### **Response (Success)**:

```json
{
  "message": "User registered successfully",
  "user_id": "60d0fe4f5311236168a109ca"
}
```

#### **Response (Failure)**:

```json
{
  "message": "User already exists"
}
```

---

### **2. Login (POST /auth/login)**

#### **Request Body**:

```json
{
  "email": "john.doe@example.com",
  "password": "password123"
}
```

#### **Response (Success)**:

```json
{
  "message": "Login successful",
  "token": "jwt_token_here"
}
```

#### **Response (Failure)**:

```json
{
  "message": "Invalid email or password"
}
```

---

## **Frontend Screens**

### **1. Login Screen**

* **UI Elements**:

  * **Email Field**
  * **Password Field** with visibility toggle
  * **Remember Me** checkbox
  * **Forgot Password** link
  * **Login Button**

* **User Flow**:

  1. User enters email and password.
  2. User clicks "Login" → triggers the `loginUser()` function.
  3. On successful login, the user is redirected to the **HomeScreen**.
  4. If there’s an error, an error message is displayed.

---

### **2. Register Screen**

* **UI Elements**:

  * **Name, Email, Password Fields**
  * **Register Button**

* **User Flow**:

  1. User enters name, email, and password.
  2. User clicks "Register" → triggers the `registerUser()` function.
  3. On successful registration, the user is redirected to the **LoginScreen**.

---

### **3. Home Screen**

* **UI Elements**:

  * A simple welcome message: "Welcome to the app"

* **User Flow**:

  * This screen is shown after a successful login, where the user is greeted.

---

## **Error Handling**

### **Common Errors**

* **Network Issues**: If the app cannot reach the backend, it will display an error message like "Could not connect to the server."
* **Invalid Credentials**: If the login fails due to invalid email/password, the app will show "Invalid email or password."
* **Duplicate User**: If the registration fails due to an existing user, the message will be "User already exists."

---

## **How to Contribute**

We welcome contributions to improve this project. If you’d like to contribute, follow these steps:

1. **Fork the repository**.
2. **Clone** your fork locally:

   ```bash
   git clone https://github.com/your-username/project-name.git
   ```
3. **Create a new branch**:

   ```bash
   git checkout -b feature-name
   ```
4. **Make changes** and **commit**:

   ```bash
   git commit -m "Add new feature"
   ```
5. **Push** the changes to your fork:

   ```bash
   git push origin feature-name
   ```
6. **Submit a pull request**.

---

## **Future Improvements**

* **Password Reset**: Implement functionality to reset the password using email.
* **Profile Update**: Allow users to update their profile information (e.g., name, email).
* **JWT Expiry**: Implement token expiry and refresh token functionality.
* **Error Logging**: Add better error logging on the frontend and backend.
* **Social Login**: Integrate social media login (e.g., Google, Facebook).

---

## **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

