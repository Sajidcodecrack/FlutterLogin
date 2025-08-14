import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_field.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

Future<void> registerUser() async {
  setState(() => _isLoading = true);

  if (_passwordController.text != _confirmPasswordController.text) {
    setState(() => _isLoading = false);
    print("Passwords do not match");
    return;
  }

  try {
    final response = await ApiService.register(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    // Check message instead of just "success" key
    if (response['success'] == true ||
        (response['message']?.toLowerCase().contains('successful') ?? false)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      print(response['message'] ?? 'Registration failed');
    }
  } catch (e) {
    setState(() => _isLoading = false);
    print('Error during registration: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Color(0xFF6C5CE7);
    final Color secondaryColor = Color(0xFFFD79A8);
    final Color darkBackground = Color(0xFF2D3436);
    final Color lightText = Color(0xFFDFE6E9);

    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: lightText, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              // Icon(Icons.diamond_outlined, size: 80, color: primaryColor),
              const SizedBox(height: 24),
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: lightText,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Join our exclusive community',
                style: TextStyle(
                  fontSize: 16,
                  color: lightText.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              CustomInputField(
                controller: _nameController,
                label: 'Full Name',
                icon: Icons.person_outline,
                lightText: lightText,
                obscureText: false,
              ),
              const SizedBox(height: 20),
              CustomInputField(
                controller: _emailController,
                label: 'Email Address',
                icon: Icons.email_outlined,
                lightText: lightText,
                primaryColor: primaryColor,
                obscureText: false,
              ),
              const SizedBox(height: 20),
              CustomInputField(
                controller: _passwordController,
                label: 'Password',
                icon: Icons.lock_outlined,
                obscureText: _obscurePassword,
                lightText: lightText,
                primaryColor: primaryColor,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: lightText.withOpacity(0.5),
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              const SizedBox(height: 20),
              CustomInputField(
                controller: _confirmPasswordController,
                label: 'Confirm Password',
                icon: Icons.lock_reset_outlined,
                obscureText: _obscureConfirmPassword,
                lightText: lightText,
                primaryColor: primaryColor,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: lightText.withOpacity(0.5),
                  ),
                  onPressed: () => setState(
                    () => _obscureConfirmPassword = !_obscureConfirmPassword,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              CustomButton(
                onPressed: _isLoading ? null : registerUser,
                buttonText: 'CREATE ACCOUNT',
                isLoading: _isLoading,
                primaryColor: primaryColor,
                lightText: lightText,
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(child: Divider(color: lightText.withOpacity(0.2))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: lightText.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: lightText.withOpacity(0.2))),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.g_mobiledata,
                      size: 36,
                      color: Colors.red[400],
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: Icon(
                      Icons.facebook,
                      size: 36,
                      color: Colors.blue[400],
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: lightText.withOpacity(0.7)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
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
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
