import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_me/screens/dashboard/components/chart_card.dart';
import 'package:look_me/screens/dashboard/components/dashboard_header.dart';
import 'package:look_me/screens/dashboard/components/dashboard_card.dart';
import 'package:look_me/screens/dashboard/components/information_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _navigationItems = [
    {
      'icon': 'assets/images/icons/home.svg',
      'label': 'Home',
      'activeColor': const Color(0xFF85A8A6),
    },
    {
      'icon': 'assets/images/icons/message.svg',
      'label': 'Pesan',
      'activeColor': const Color(0xFF85A8A6),
    },
    {
      'icon': 'assets/images/icons/shield2.svg',
      'label': 'Perizinan',
      'activeColor': const Color(0xFF85A8A6),
    },
    {
      'icon': Icons.history,
      'label': 'Riwayat',
      'activeColor': const Color(0xFF85A8A6),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SafeArea(
          child: ListView(
            children: const [
              DashboardHeader(),
              DashboardCard(),
              InformationCard(),
              ChartCard(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          // Tambahkan logika untuk face scan
        },
        backgroundColor: const Color(0xFF116256),
        child: const Icon(Icons.face_unlock_sharp, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade100,
        elevation: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(2, (index) => _buildNavItem(index)),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(2, (index) => _buildNavItem(index + 2)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    return MaterialButton(
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_navigationItems[index]['icon'] is String)
            SvgPicture.asset(
              _navigationItems[index]['icon'],
              colorFilter: ColorFilter.mode(
                _selectedIndex == index
                    ? _navigationItems[index]['activeColor']
                    : Colors.grey,
                BlendMode.srcIn,
              ),
            )
          else
            Icon(
              _navigationItems[index]['icon'],
              color: _selectedIndex == index
                  ? _navigationItems[index]['activeColor']
                  : Colors.grey,
            ),
          const SizedBox(height: 4),
          Text(
            _navigationItems[index]['label'],
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
