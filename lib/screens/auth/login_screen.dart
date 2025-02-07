import 'package:flutter/material.dart';
import 'package:look_me/screens/auth/components/login_body.dart';
import 'package:look_me/screens/home/components/home_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF3F1),
      body: ListView(
        children: const [
          HomeHeader(
            topPadding: 0.0,
          ),
          LoginBody(),
        ],
      ),
    );
  }
}
