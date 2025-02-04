import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final double width;
  final Color color;
  final VoidCallback? onTap;

  const Indicator({
    super.key,
    this.width = 10,
    this.color = Colors.grey,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        width: width,
        height: 10,
        margin: const EdgeInsets.only(right: 7),
      ),
    );
  }
}
