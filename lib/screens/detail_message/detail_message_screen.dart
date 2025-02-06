import 'package:flutter/material.dart';
import 'package:look_me/screens/detail_message/components/header_detail_screen.dart';
import 'package:look_me/screens/detail_message/components/popup_message_screen.dart';

class DetailMessageScreen extends StatefulWidget {
  const DetailMessageScreen({super.key});

  @override
  State<DetailMessageScreen> createState() => _DetailMessageScreenState();
}

class _DetailMessageScreenState extends State<DetailMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          const HeaderDetailScreen(),
          const PopupMessageScreen(),
        ],
      ),
    );
  }
}
