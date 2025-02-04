import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_me/styles/styles.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: SvgPicture.asset('assets/images/auth/login.svg'),
          ),

          // buatkan saya form login
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // hias textformfield dengan border radius 10.0 dan berikan border dengan warna biru
                const Text(
                  'Username',
                  textAlign: TextAlign.left,
                  style: AuthStyles.labelStyle,
                ),
                const SizedBox(height: 10.0),
                // beri icon di dalam textformfield dan berikan icon dengan warna biru
                TextFormField(
                  decoration: AuthStyles.textFieldDecoration(
                    hintText: 'Masukkan Username',
                    prefixIcon: Icons.person,
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
                  obscureText: !isPasswordVisible,
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
                SizedBox(
                  width: double.infinity,
                  height: 55.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    },
                    style: AuthStyles.loginButtonStyle,
                    child: const Text(
                      'Login',
                      style: AuthStyles.buttonTextStyle,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/forgot-password');
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
          ),
        ],
      ),
    );
  }
}
