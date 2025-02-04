import 'package:flutter/material.dart';
import 'package:look_me/screens/auth/components/verify.dart';
import 'package:look_me/screens/home/components/home_header.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          HomeHeader(
            topPadding: 0.0,
          ),
          Verify(),
        ],
      ),
    );
  }
}
