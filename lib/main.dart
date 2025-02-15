import 'package:flutter/material.dart';
import 'package:look_me/screens/auth/forgot_password.dart';
import 'package:look_me/screens/auth/login_screen.dart';
import 'package:look_me/screens/auth/reset_password.dart';
import 'package:look_me/screens/auth/verify_screen.dart';
import 'package:look_me/screens/dashboard/dashboard_screen.dart';
import 'package:look_me/screens/detail_message/detail_message_screen.dart';
import 'package:look_me/screens/history/history_screen.dart';
import 'package:look_me/screens/home/home_screen.dart';
import 'package:look_me/screens/messages/message_screen.dart';
import 'package:look_me/screens/notify/danger_screen.dart';
import 'package:look_me/screens/notify/success_screen.dart';
import 'package:look_me/screens/permission/add_permission.dart';
import 'package:look_me/screens/permission/permission_screen.dart';
import 'package:look_me/screens/scan/scan_face.dart';
import 'package:look_me/store/session.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SessionStore()),
      ],
      child: const MyApp(),
    )
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LookMe',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
      ),
      // protect route when user is not logged in
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/verify-otp': (context) => const VerifyScreen(),
        '/reset-password': (context) => const ResetPassword(),
        '/dashboard': (context) => const DashboardScreen(),
        '/message': (context) => const MessageScreen(),
        '/detail-message': (context) => const DetailMessageScreen(),
        '/scan-face': (context) => const ScanFace(),
        '/success': (context) => const SuccessScreen(),
        '/danger': (context) => const DangerScreen(),
        '/permission': (context) => const PermissionScreen(),
        '/add-permission': (context) => const AddPermissionScreen(),
        '/history': (context) => const HistoryScreen(),
      },
    );
  }
}
