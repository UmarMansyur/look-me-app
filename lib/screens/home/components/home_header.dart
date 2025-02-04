import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    this.topPadding = 40.0,
    this.leftPadding = 20.0,
  });

  final double topPadding;
  final double leftPadding;

  static const TextStyle titleStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: Color(0xFF0B3D41),
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding, top: topPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('LookMe', style: titleStyle),
          Text(
            'Your Face is Your Key',
            style: TextStyle(
              // ignore: deprecated_member_use
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
