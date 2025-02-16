// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';

class DashboardCard extends StatefulWidget {
  final Map<String, dynamic> data;
  const DashboardCard({super.key, required this.data});

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  String _getHariIni() {
    List<String> hari = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu'
    ];

    // weekday returns 1-7 where 1 is Monday
    int dayIndex = DateTime.now().weekday - 1;
    return hari[dayIndex];
  }

  String _currentLocation = 'Memuat lokasi...';

  Future<void> _getCurrentLocationFromGPSGoogle() async {
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _currentLocation = 'Izin lokasi ditolak';
          });
          return;
        }
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentLocation = '${position.latitude}, ${position.longitude}';
      });
    } catch (e) {
      setState(() {
        _currentLocation = 'Gagal mendapatkan lokasi';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocationFromGPSGoogle();
  }

  // get data from api

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      // berikan shadow di BoxDecoration
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF063039),
            const Color(0xFF063039).withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      _getHariIni(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Waktu Kehadiran:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              widget.data['data']?['today_present']
                                      ?['check_in'] ??
                                  'Tidak Ada',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            const SizedBox(width: 2),
                            const Icon(
                              Icons.watch_later_outlined,
                              color: Colors.white,
                              size: 24,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // icon map
                        const Icon(
                          Icons.map_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _currentLocation,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: SvgPicture.asset(
              'assets/images/clover.svg',
            ),
          ),
          Positioned(
            top: 20,
            right: 10,
            child: SvgPicture.asset(
              'assets/images/square1.svg',
            ),
          ),
        ],
      ),
    );
  }
}
