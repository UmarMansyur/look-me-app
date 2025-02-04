import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_me/screens/auth/components/remember_password.dart';
import 'package:look_me/screens/auth/login_screen.dart';
import 'package:look_me/styles/styles.dart';

class ResetPasswordBody extends StatefulWidget {
  const ResetPasswordBody({super.key});

  @override
  State<ResetPasswordBody> createState() => _ResetPasswordBodyState();
}

class _ResetPasswordBodyState extends State<ResetPasswordBody> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: SvgPicture.asset('assets/images/auth/confirm-password.svg'),
          ),

          // buatkan saya form login
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Password Baru',
                  textAlign: TextAlign.left,
                  style: AuthStyles.labelStyle,
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  obscureText: !isPasswordVisible,
                  decoration: AuthStyles.textFieldDecoration(
                    hintText: 'Password Baru',
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
                const Text(
                  'Konfirmasi Password',
                  textAlign: TextAlign.left,
                  style: AuthStyles.labelStyle,
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  obscureText: !isPasswordVisible,
                  decoration: AuthStyles.textFieldDecoration(
                    hintText: 'Konfirmasi Password',
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
                SizedBox(
                  width: double.infinity,
                  height: 55.0,
                  child: ElevatedButton(
                    onPressed: () {
                      // redirect ke halaman login
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    style: AuthStyles.loginButtonStyle,
                    child: const Text(
                      'Simpan',
                      style: AuthStyles.buttonTextStyle,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const RememberPassword()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
