import 'package:flutter/material.dart';
import 'package:look_me/components/parent.dart';
import 'package:look_me/screens/permission/components/header_screen.dart';
import 'package:look_me/screens/permission/components/information_screen.dart';
import 'package:look_me/screens/permission/components/permission_status.dart';
import 'package:look_me/styles/styles.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Parent(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Stack(
            children: [
              const Column(
                children: [
                  HeaderScreen(),
                  InformationScreen(),
                  PermissionStatus()
                ],
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: AuthStyles.primaryGradientColor),
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
                    icon: const Icon(Icons.add,
                        color: Colors.white, size: 26),
                  ),
                ),
              ),
            ],
        ),
      ),
    );
  }
}
