import 'package:flutter/material.dart';
import 'package:look_me/screens/home/components/home_header.dart';
import 'package:look_me/screens/home/components/steps.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // EBF3F1
    return Scaffold(
      backgroundColor: const Color(0xFFEBF3F1),
      body: ListView(
        children: const [
          HomeHeader(),
          Steps(),
        ],
      ),
    );
  }
}
