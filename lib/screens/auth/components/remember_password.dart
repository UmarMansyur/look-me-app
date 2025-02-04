import 'package:flutter/material.dart';
import 'package:look_me/styles/styles.dart';
import 'package:flutter/gestures.dart';

class RememberPassword extends StatelessWidget {
  const RememberPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Ingat password ? ',
                style: AuthStyles.forgotPasswordStyle.copyWith(
                  fontSize: 14.0,
                ),
              ),
              TextSpan(
                text: 'Login',
                style: AuthStyles.forgotPasswordStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.pushNamed(context, '/login'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
