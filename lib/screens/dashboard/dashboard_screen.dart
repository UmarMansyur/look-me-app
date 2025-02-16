import 'package:flutter/material.dart';
import 'package:look_me/components/parent.dart';
import 'package:look_me/network/api.dart';
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
  Map<String, dynamic> _data = {};
  List<dynamic> _kehadiranTahunan1 = [];
  List<dynamic> _kehadiranTahunan2 = [];
  Future<void> _getData() async {
    final response = await Api.getRequest('dashboard/employee', true);

    setState(() {
      _data = response ?? {};
      // ambil 6 data terakhir
      _kehadiranTahunan2 = _data['data']?['kehadiran_tahunan']
              ?.sublist(_data['data']?['kehadiran_tahunan']?.length - 6) ??
          [];
      // ambil 6 data terawal
      _kehadiranTahunan1 =
          _data['data']?['kehadiran_tahunan']?.sublist(0, 6) ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      child: ListView(
        children: [
          Column(
            children: [
              const DashboardHeader(),
              DashboardCard(
                data: _data,
              ),
              InformationCard(
                informationCard: [
                  {
                    'icon': 'assets/images/icons/clock.svg',
                    'title': 'Total Kehadiran',
                    'amount': '${_data['data']?['total_kehadiran']}'
                  },
                  {
                    'icon': 'assets/images/icons/shield.svg',
                    'title': 'Jumlah Izin',
                    'amount': '${_data['data']?['total_permission']}'
                  }
                ],
              ),
              ChartCard(
                data: _kehadiranTahunan1,
              ),
              ChartCard(
                data: _kehadiranTahunan2,
              ),
              // HistoryCard(
              //   history: _data['data']?['history_kehadiran'] ?? [],
              // )
            ],
          ),
        ],
      ),
    );
  }
}
