// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AuthStyles {
  static const Color primaryColor = Color(0xFF608384);
  static const Color primary2Color = Color(0xFF0A3C40);
  static const Color buttonColor = Color(0xFF2CD097);
  static const primaryGradientColor = [
    Color(0xFF0A3C40),
    Color(0xFF125F55),
  ];

  static const TextStyle labelStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: primaryColor,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
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
      fillColor: const Color(0xFFEBF3F1),
      focusColor: const Color(0xFFEBF3F1),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Color(0xFFEBF3F1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(
          color: Color(0xFFEBF3F1),
          width: 1.0,
        ),
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: Colors.black12,
        size: 24.0,
      ),
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Colors.black26,
        fontWeight: FontWeight.w300,
      ),
      suffixIcon: suffixIcon,
    );
  }

  static ButtonStyle loginButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primary2Color,
    shadowColor: primary2Color.withOpacity(0.5),
    elevation: 10.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
    ),
  );
}
