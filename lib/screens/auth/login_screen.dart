import 'package:flutter/material.dart';
import 'package:look_me/screens/auth/components/login_body.dart';
import 'package:look_me/screens/home/components/home_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // tombol back
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
            ],
          ),
          HomeHeader(
            topPadding: 0.0,
          ),
          LoginBody(),
        ],
      ),
    );
  }
}
