import 'package:flutter/material.dart';
import 'package:look_me/network/api.dart';
import 'package:look_me/screens/detail_message/components/header_detail_screen.dart';
import 'package:look_me/screens/detail_message/components/popup_message_screen.dart';

class DetailMessageScreen extends StatefulWidget {
  const DetailMessageScreen({super.key});

  @override
  State<DetailMessageScreen> createState() => _DetailMessageScreenState();
}

class _DetailMessageScreenState extends State<DetailMessageScreen> {
  Map<String, dynamic> _detailMessage = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
  }

  Future<void> _getData() async {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    final response = await Api.getRequest('warning-letter/data/$id', true);
    setState(() {
      _detailMessage = response?['data'] ?? {};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          HeaderDetailScreen(detailMessage: _detailMessage),
          PopupMessageScreen(),
        ],
      ),
    );
  }
}
