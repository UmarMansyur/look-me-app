import 'package:flutter/material.dart';
import 'package:look_me/components/parent.dart';
import 'package:look_me/screens/dashboard/components/chart_card.dart';
import 'package:look_me/screens/dashboard/components/dashboard_header.dart';
import 'package:look_me/screens/dashboard/components/dashboard_card.dart';
import 'package:look_me/screens/dashboard/components/history_card.dart';
import 'package:look_me/screens/dashboard/components/information_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return const Parent(
      child: Column(
        children: [
          DashboardHeader(),
          DashboardCard(),
          InformationCard(),
          ChartCard(),
          HistoryCard()
        ],
      ),
    );
  }
}
