import 'package:flutter/material.dart';
import 'package:look_me/components/avatar.dart';
import 'package:look_me/components/header_icon.dart';
import 'package:look_me/format/date/date.dart';

class DashboardHeader extends StatefulWidget {
  const DashboardHeader({super.key});

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            const Avatar(
              width: 45,
              height: 45,
              backgroundColor: Colors.grey,
              imageUrl:
                  'https://ik.imagekit.io/8zmr0xxik/Colorful_Gradient_Background_Man_3D_Avatar_4F0kSVV0X.png?updatedAt=1709258633386',
              radius: 20,
            ),
            const SizedBox(width: 20),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Halo, Umar \n',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  TextSpan(
                    // tanggal sekarang
                    text: DateFormat.formatIndonesian(DateTime.now()),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        HeaderIcon(
          icon: Icons.notifications,
          onPressed: () {},
        ),
      ],
    );
  }
}
