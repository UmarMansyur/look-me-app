import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});
  static const TextStyle titleStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: Color(0xFF0B3D41),
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('LookMe', style: titleStyle),
          Text(
            'Your Face is Your Key',
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
