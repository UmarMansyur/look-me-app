import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_me/components/avatar.dart';
import 'package:look_me/store/session.dart';
import 'package:provider/provider.dart';

class HeaderScreen extends StatelessWidget {
  const HeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<SessionStore>(context, listen: false);
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Avatar(
                  width: 45,
                  height: 45,
                  backgroundColor: Colors.grey,
                  imageUrl: session.user['thumbnail'] ?? '',
                  radius: 20,
                  borderColor: Colors.white,
                ),
                const SizedBox(width: 20),
                const Text(
                  'Perizinan',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/icons/filter.svg',
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 10),
                SvgPicture.asset(
                  'assets/images/icons/bell.svg',
                  width: 24,
                  height: 24,
                ),
              ],
            ),
            // list Pesan
          ],
        ),
      ),
    );
  }
}
