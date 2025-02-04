import 'package:flutter/material.dart';
import 'package:look_me/screens/auth/components/reset_password_body.dart';
import 'package:look_me/screens/home/components/home_header.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          HomeHeader(),
          ResetPasswordBody(),
        ],
      ),
    );
  }
}
