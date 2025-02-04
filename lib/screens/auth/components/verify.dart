import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_me/screens/auth/components/remember_password.dart';
import 'package:look_me/styles/styles.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: SvgPicture.asset('assets/images/auth/verify-otp.svg'),
          ),

          // buatkan saya form login
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Kode OTP',
                      textAlign: TextAlign.center,
                      style: AuthStyles.labelStyle.copyWith(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Kode OTP sudah dikirimkan ke email anda!',
                      textAlign: TextAlign.center,
                      style: AuthStyles.labelStyle.copyWith(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),

                // Buatkan saya 5 kotak inputan dengan border radius 10.0 dan berikan border dengan warna biru
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    5,
                    (index) => SizedBox(
                      height: 50,
                      width: 60,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xFF608384)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xFF608384)),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.length == 1 && index < 4) {
                            FocusScope.of(context).nextFocus();
                          }
                          // jika dihapus maka focus ke textformfield sebelumnya
                          if (value.isEmpty && index > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Masukkan kode OTP Sebelum ',
                              style: AuthStyles.labelStyle.copyWith(
                                fontSize: 12.0,
                                color: Colors.grey,
                              )),
                          TextSpan(
                              text: '00:50',
                              style: AuthStyles.labelStyle.copyWith(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30.0),
                // container button login
                SizedBox(
                  width: double.infinity,
                  height: 55.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/reset-password');
                    },
                    style: AuthStyles.loginButtonStyle,
                    child: const Text(
                      'Verifikasi',
                      style: AuthStyles.buttonTextStyle,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const RememberPassword(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
