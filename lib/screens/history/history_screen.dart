import 'package:flutter/material.dart';
import 'package:look_me/components/parent.dart';
import 'package:look_me/screens/history/components/header_history.dart';
import 'package:look_me/screens/history/components/history_body.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return const Parent(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          HeaderHistory(),
          HistoryBody(),
        ],
      ),
    );
  }
}
