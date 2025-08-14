import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register_screen.dart';
import 'home_screen.dart'; 
import '../services/api_service.dart'; // Add this import for ApiService

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = false;
  bool _obscurePassword = true;

  Future<void> loginUser() async {
  setState(() => _isLoading = true);

  try {
    final response = await ApiService.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (response['success'] == true ||
        (response['message']?.toLowerCase().contains('login successful') ?? false)) {
      // Save token if your backend sends one
      if (response['token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response['token']);
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      print(response['message'] ?? 'Login failed');
    }
  } catch (e) {
    setState(() => _isLoading = false);
    print('Error during login: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Color(0xFF6C5CE7); // Deep purple
    final Color secondaryColor = Color.fromRGBO(189, 238, 73, 1); // Soft pink
    final Color darkBackground = Color(0xFF2D3436); // Dark slate
    final Color lightText = Color(0xFFDFE6E9); // Light gray
    final Color inputBackground = Color(0xFF636E72).withOpacity(0.3);

    return Scaffold(
      backgroundColor: darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              // App Logo
              // Icon(
              //   Icons.diamond_outlined,
              //   size: 100,
              //   color: primaryColor,
              // ),
              SizedBox(height: 24),
              Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: lightText,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Sign in to your account',
                style: TextStyle(
                  fontSize: 16,
                  color: lightText.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              
              // Email Field
              TextField(
                controller: _emailController,
                style: TextStyle(color: lightText),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: lightText.withOpacity(0.7)),
                  prefixIcon: Icon(Icons.email, color: lightText.withOpacity(0.7)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor.withOpacity(0.5)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  filled: true,
                  fillColor: inputBackground,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              
              // Password Field
              TextField(
                controller: _passwordController,
                style: TextStyle(color: lightText),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: lightText.withOpacity(0.7)),
                  prefixIcon: Icon(Icons.lock, color: lightText.withOpacity(0.7)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      color: lightText.withOpacity(0.7),
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor.withOpacity(0.5)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  
                  filled: true,
                  fillColor: inputBackground,
                ),
                obscureText: _obscurePassword,
              ),
              SizedBox(height: 16),
              
              // Remember Me & Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: lightText.withOpacity(0.7),
                        ),
                        child: Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() => _rememberMe = value!);
                          },
                          activeColor: primaryColor,
                          checkColor: darkBackground,
                        ),
                      ),
                      Text('Remember me', style: TextStyle(color: lightText.withOpacity(0.8))),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // Add forgot password functionality
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: secondaryColor),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              
              // Login Button
              ElevatedButton(
                onPressed: _isLoading ? null : loginUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  shadowColor: primaryColor.withOpacity(0.5),
                ),
                child: _isLoading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation(lightText),
                        ),
                      )
                    : Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: lightText,
                          letterSpacing: 1.1,
                        ),
                      ),
              ),
              SizedBox(height: 30),
              
              // Divider with "OR"
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: lightText.withOpacity(0.2),
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'OR CONTINUE WITH',
                      style: TextStyle(
                        color: lightText.withOpacity(0.6),
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: lightText.withOpacity(0.2),
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              
              // Social Login Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.g_mobiledata, size: 24),
                    label: Text('Google'),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkBackground,
                      foregroundColor: lightText,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: lightText.withOpacity(0.2)),
                      ),
                      elevation: 0,
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton.icon(
                    icon: Icon(Icons.facebook, size: 24),
                    label: Text('Facebook'),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkBackground,
                      foregroundColor: lightText,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: lightText.withOpacity(0.2)),
                      ),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              
              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: lightText.withOpacity(0.7),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}