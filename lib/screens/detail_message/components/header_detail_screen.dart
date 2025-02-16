import 'package:flutter/material.dart';
import 'package:look_me/components/avatar.dart';

class HeaderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> detailMessage;

  const HeaderDetailScreen({
    super.key,
    required this.detailMessage,
  });

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
          Avatar(
            width: 45,
            height: 45,
            backgroundColor: Colors.grey,
            imageUrl: detailMessage['thumbnail'] ?? '',
            radius: 20,
            borderColor: Colors.white,
          ),
          const SizedBox(width: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${detailMessage['username'] ?? 'Loading...'}\n',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const TextSpan(
                  text: 'Online',
                  style: const TextStyle(
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
