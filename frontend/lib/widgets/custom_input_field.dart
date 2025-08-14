import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final IconData? icon;
  final Widget? suffixIcon;
  final Color? lightText;
  final Color? primaryColor;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.obscureText,
    this.icon,
    this.suffixIcon,
    this.lightText,
    this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: lightText ?? Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: lightText?.withOpacity(0.7) ?? Colors.white70),
        prefixIcon: icon != null ? Icon(icon, color: primaryColor ?? Colors.white) : null,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
