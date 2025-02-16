import 'package:flutter/material.dart';
import 'package:look_me/screens/auth/components/login_button.dart';
import 'package:look_me/styles/styles.dart';

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
            child: LoginButton(
                email: emailController.text, password: passwordController.text),
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
