import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:look_me/network/api/auth.dart';
import 'package:look_me/store/session.dart';
import 'package:look_me/store/token.dart';
import 'package:look_me/styles/styles.dart';
import 'package:provider/provider.dart';
class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  bool isPasswordVisible = false;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        children: [
          Form(
            key: formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Image.asset('assets/images/auth/login.png'),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email',
                        textAlign: TextAlign.left,
                        style: AuthStyles.labelStyle,
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: emailController,
                        decoration: AuthStyles.textFieldDecoration(
                          hintText: 'Masukkan Email',
                          prefixIcon: Icons.email,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Password',
                        textAlign: TextAlign.left,
                        style: AuthStyles.labelStyle,
                      ),
                      const SizedBox(height: 10.0),
                      // beri tombol show password, jangan lupa text ubah menjadi password
                      TextFormField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                        decoration: AuthStyles.textFieldDecoration(
                          hintText: 'Masukkan Password',
                          prefixIcon: Icons.lock,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              !isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      // container button login
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            width: double.infinity,
            height: 55.0,
            child: ElevatedButton(
              onPressed: () async {
                final response = await AuthApi.login(emailController.text, passwordController.text);
                if(response?['status'] == true) {
                  await TokenStore.saveToken(json.encode(response?['data']));
                  final data = await TokenStore.decodeToken();
                  Provider.of<SessionStore>(context, listen: false).setUser({
                    'id': data?['data']['id'],
                    'username': data?['data']['username'],
                    'email': data?['data']['email'],
                    'phone': data?['data']['phone'],
                    'date_of_birth': data?['data']['date_of_birth'],
                    'address': data?['data']['address'],
                    'thumbnail': data?['data']['thumbnail'],
                    'gender': data?['data']['gender'],
                    'institution_id': data?['data']['userInstitutions']?[0]['id'],
                  });
                  // Navigator.pushReplacementNamed(context, '/dashboard');
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(response?['message'] ?? 'Login failed'), backgroundColor: const Color(0xFFE81D1D),),
                  );
                }
              },
              style: AuthStyles.loginButtonStyle,
              child: const Text(
                'Login',
                style: AuthStyles.buttonTextStyle,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/forgot-password');
                },
                child: Text(
                  'Forgot Password ?',
                  style: AuthStyles.forgotPasswordStyle.copyWith(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
