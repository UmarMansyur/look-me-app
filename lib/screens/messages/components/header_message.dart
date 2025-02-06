import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_me/components/avatar.dart';

class HeaderMessage extends StatelessWidget {
  const HeaderMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Avatar(
                  width: 45,
                  height: 45,
                  backgroundColor: Colors.grey,
                  imageUrl:
                      'https://ik.imagekit.io/8zmr0xxik/Colorful_Gradient_Background_Man_3D_Avatar_4F0kSVV0X.png?updatedAt=1709258633386',
                  radius: 20,
                  borderColor: Colors.white,
                ),
                SizedBox(width: 20),
                Text(
                  'Pesan',
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
