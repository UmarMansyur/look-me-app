import 'package:flutter/material.dart';
import 'package:look_me/components/avatar.dart';

class HeaderDetailScreen extends StatelessWidget {
  const HeaderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left),
          ),
          const Avatar(
            width: 45,
            height: 45,
            backgroundColor: Colors.grey,
            imageUrl:
                'https://ik.imagekit.io/8zmr0xxik/Colorful_Gradient_Background_Man_3D_Avatar_4F0kSVV0X.png?updatedAt=1709258633386',
            radius: 20,
            borderColor: Colors.white,
          ),
          const SizedBox(width: 10),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Pengguna 1 \n',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                TextSpan(
                  text: 'Online',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black26,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
