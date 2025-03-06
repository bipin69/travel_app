import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final String hintText;
  final IconData? icon; // Added icon property
  final bool isPassword; // Added isPassword property to control visibility

  const CustomTextField({
    super.key,
    required this.controller,
    required this.validator,
    required this.keyboardType,
    required this.hintText,
    this.icon, // Optional icon parameter
    this.isPassword = false, // Default to false if not a password field
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: isPassword, // If it's a password, it will be obscured
      style: const TextStyle(fontSize: 19.0, color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        filled: true,
        fillColor: const Color.fromARGB(255, 244, 246, 247),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.black),
        ),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 18.0, color: Colors.black45),
        prefixIcon: icon != null
            ? Icon(icon, color: Colors.black) // Show icon if available
            : null,
      ),
    );
  }
}
