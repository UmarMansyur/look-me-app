import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Parent extends StatefulWidget {
  const Parent({super.key, required this.child});

  final Widget child;

  @override
  State<Parent> createState() => _ParentState();
}

class _ParentState extends State<Parent> {
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
        padding: const EdgeInsets.all(15),
        child: SafeArea(
          child: ListView(
            children: [widget.child],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          // Tambahkan logika untuk face scan
        },
        backgroundColor: Colors.white,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF116256),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0B4042).withOpacity(0.1),
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              'assets/images/icons/face.svg',
              fit: BoxFit.contain,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shadowColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            4,
            (index) => _buildNavItem(index),
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
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Text(
              _navigationItems[index]['label'],
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: _selectedIndex == index
                    ? _navigationItems[index]['activeColor']
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
