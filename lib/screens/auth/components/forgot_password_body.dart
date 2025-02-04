import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_me/screens/auth/components/remember_password.dart';
import 'package:look_me/styles/styles.dart';

class ForgotPasswordBody extends StatefulWidget {
  const ForgotPasswordBody({super.key});

  @override
  State<ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: SvgPicture.asset('assets/images/auth/forgot-password.svg'),
          ),

          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      'Masukkan email anda, sistem kami akan mengirimkan \n kode ',
                  style: AuthStyles.forgotPasswordStyle.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextSpan(
                  text: 'OTP',
                  style: AuthStyles.forgotPasswordStyle.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' untuk mengubah password anda!',
                  style: AuthStyles.forgotPasswordStyle.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          // buatkan saya form login
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // hias textformfield dengan border radius 10.0 dan berikan border dengan warna biru
                const Text(
                  'Email',
                  textAlign: TextAlign.left,
                  style: AuthStyles.labelStyle,
                ),
                const SizedBox(height: 20.0),
                // beri icon di dalam textformfield dan berikan icon dengan warna biru
                TextFormField(
                  decoration: AuthStyles.textFieldDecoration(
                    hintText: 'Masukkan Email',
                    prefixIcon: Icons.email,
                  ),
                ),

                const SizedBox(height: 40.0),
                // container button login
                SizedBox(
                  width: double.infinity,
                  height: 55.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/verify-otp');
                    },
                    style: AuthStyles.loginButtonStyle,
                    child: const Text(
                      'Kirim OTP',
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
