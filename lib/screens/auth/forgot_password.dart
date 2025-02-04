import 'package:flutter/material.dart';
import 'package:look_me/screens/auth/components/forgot_password_body.dart';
import 'package:look_me/screens/home/components/home_header.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          HomeHeader(),
          ForgotPasswordBody(),
        ],
      ),
    );
  }
}
