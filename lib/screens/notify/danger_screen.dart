import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_me/screens/scan/scan_face.dart';
import 'package:look_me/styles/styles.dart';

class DangerScreen extends StatelessWidget {
  const DangerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECEFEE),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              children: [
                Text(
                  'Verifikasi Gagal!',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.black87),
                ),
                Text(
                  'Pastikan pencahayaan cukup dan wajah terlihat jelas',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 10),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    // child adalah segi 5
                    child: SizedBox(
                      height: 180,
                      width: 180,
                      child: SvgPicture.asset('assets/images/notify/danger.svg'),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: AuthStyles.primaryGradientColor,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ScanFace()));
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Coba Lagi',
                      style: AuthStyles.buttonTextStyle.copyWith(
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
