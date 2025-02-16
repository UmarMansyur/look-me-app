import 'package:flutter/material.dart';
import 'package:look_me/components/parent.dart';
import 'package:look_me/screens/messages/components/body_message.dart';
import 'package:look_me/screens/messages/components/header_message.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return const Parent(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const HeaderMessage(),
          const BodyMessage(),
        ],
      ),
    );
  }
}
