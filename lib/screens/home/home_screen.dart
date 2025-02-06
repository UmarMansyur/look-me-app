import 'package:flutter/material.dart';
import 'package:look_me/components/parent.dart';
import 'package:look_me/screens/home/components/home_body.dart';
import 'package:look_me/screens/home/components/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Parent(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          HomeHeader(),
          HomeBody(),
        ],
      ),
    );
  }
}
