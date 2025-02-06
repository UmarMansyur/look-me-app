import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.imageUrl,
    required this.radius,
    this.borderColor,
  });
  final MaterialColor backgroundColor;
  final String imageUrl;
  final double radius;
  final Color? borderColor;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 50,
      height: height ?? 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor ?? const Color(0xFF063039),
          width: 2,
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
