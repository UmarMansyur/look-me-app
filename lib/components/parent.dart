import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Parent extends StatefulWidget {
  const Parent({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(5),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  State<Parent> createState() => _ParentState();
}

class _ParentState extends State<Parent> {
  final List<Map<String, dynamic>> _navigationItems = [
    {
      'icon': 'assets/images/icons/home.svg',
      'label': 'Home',
      'activeColor': const Color(0xFF85A8A6),
      'route': '/dashboard',
    },
    {
      'icon': 'assets/images/icons/message.svg',
      'label': 'Pesan',
      'activeColor': const Color(0xFF85A8A6),
      'route': '/message',
    },
    {
      'icon': 'assets/images/icons/shield2.svg',
      'label': 'Perizinan',
      'activeColor': const Color(0xFF85A8A6),
      'route': '/permission',
    },
    {
      'icon': Icons.history,
      'label': 'Riwayat',
      'activeColor': const Color(0xFF85A8A6),
      'route': '/history',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: widget.padding,
          child: widget.child,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.pushNamed(context, '/scan-face');
        },
        backgroundColor: Colors.white,
        child: Container(
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
        notchMargin: 8,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
        Navigator.pushNamed(context, _navigationItems[index]['route']);
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
                // jika sama dengan nama route yang sekarang maka warnanya active
                colorFilter: _navigationItems[index]['route'] ==
                        ModalRoute.of(context)?.settings.name
                    ? ColorFilter.mode(
                        _navigationItems[index]['activeColor'],
                        BlendMode.srcIn,
                      )
                    : const ColorFilter.mode(
                        Colors.grey,
                        BlendMode.srcIn,
                      ),
              )
            else
              Icon(
                _navigationItems[index]['icon'],
                color: _navigationItems[index]['route'] ==
                        ModalRoute.of(context)?.settings.name
                    ? _navigationItems[index]['activeColor']
                    : Colors.grey,
              ),
            Text(
              _navigationItems[index]['label'],
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: _navigationItems[index]['route'] ==
                        ModalRoute.of(context)?.settings.name
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
