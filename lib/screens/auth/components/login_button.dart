import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:look_me/network/api/auth.dart';
import 'package:look_me/store/session.dart';
import 'package:look_me/store/token.dart';
import 'package:look_me/styles/styles.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatefulWidget {
  final String email;
  final String password;
  const LoginButton({super.key, required this.email, required this.password});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final currentContext = context;
        AuthApi.login(widget.email, widget.password).then((response) async {
          if (response?['status'] == true) {
            await TokenStore.saveToken(json.encode(response?['data']));
            final data = await TokenStore.decodeToken();
            if (!currentContext.mounted) return;
            Provider.of<SessionStore>(currentContext, listen: false)
                .setUser(data?['data']);
            Navigator.pushReplacementNamed(currentContext, '/dashboard');
          } else {
            if (!currentContext.mounted) return;
            ScaffoldMessenger.of(currentContext).showSnackBar(
              SnackBar(
                content: Text(response?['message'] ?? 'Login failed'),
                backgroundColor: const Color(0xFFE81D1D),
              ),
            );
          }
        });
      },
      style: AuthStyles.loginButtonStyle,
      child: const Text(
        'Login',
        style: AuthStyles.buttonTextStyle,
      ),
    );
  }
}
