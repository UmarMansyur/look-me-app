import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar(
      {super.key,
      required this.backgroundColor,
      required this.imageUrl,
      required this.radius});
  final MaterialColor backgroundColor;
  final String imageUrl;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF063039),
          width: 2, // Anda bisa menyesuaikan ketebalan border
        ),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor,
        backgroundImage: NetworkImage(
          imageUrl,
        ),
      ),
    );
  }
}
