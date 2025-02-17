import 'package:flutter/material.dart';
import 'package:look_me/components/parent.dart';
import 'package:look_me/network/api.dart';
import 'package:look_me/screens/permission/components/header_screen.dart';
import 'package:look_me/screens/permission/components/information_screen.dart';
import 'package:look_me/screens/permission/components/permission_status.dart';
import 'package:look_me/styles/styles.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  dynamic insights = {};
  List<Map<String, dynamic>> permissions = [];
  Future<void> _getData() async {
    final response =
        await Api.getRequest('permission-request/my-request', true);
    if (response != null && response['data'] != null) {
      setState(() {
        insights = {
          'total_sakit': response['data']['total_sakit'],
          'total_izin': response['data']['total_izin'],
          'total_cuti': response['data']['total_cuti'],
        };
        permissions = List<Map<String, dynamic>>.from(response['data']['data']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const HeaderScreen(),
                InformationScreen(insights: insights),
                PermissionStatus(permissions: permissions),
              ],
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: AuthStyles.primaryGradientColor),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-permission');
                  },
                  icon: const Icon(Icons.add, color: Colors.white, size: 26),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
