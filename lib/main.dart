import 'package:flutter/material.dart';
import 'package:look_me/screens/auth/forgot_password.dart';
import 'package:look_me/screens/auth/login_screen.dart';
import 'package:look_me/screens/auth/reset_password.dart';
import 'package:look_me/screens/auth/verify_screen.dart';
import 'package:look_me/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LookMe',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/verify-otp': (context) => const VerifyScreen(),
        '/reset-password': (context) => const ResetPassword(),
      },
    );
  }
}
