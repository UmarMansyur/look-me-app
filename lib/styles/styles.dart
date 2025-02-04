import 'package:flutter/material.dart';

class AuthStyles {
  static const Color primaryColor = Color(0xFF608384);
  static const Color buttonColor = Color(0xFF2CD097);

  static const TextStyle labelStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: primaryColor,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 24.0,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  static const TextStyle forgotPasswordStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.0,
    color: primaryColor,
  );

  static InputDecoration textFieldDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      fillColor: Colors.white,
      focusColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: primaryColor,
          width: 1.0,
        ),
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: Colors.black12,
        size: 24.0,
      ),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.black12),
      suffixIcon: suffixIcon,
    );
  }

  static ButtonStyle loginButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: buttonColor,
    elevation: 10.0,
    shadowColor: buttonColor.withOpacity(0.5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
    ),
  );
}
