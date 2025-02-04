import 'package:flutter/material.dart';
import 'package:look_me/screens/home/components/home_body.dart';
import 'package:look_me/screens/home/components/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHeader(),
          HomeBody(),
        ],
      ),
    );
  }
}
