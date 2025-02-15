// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:look_me/screens/history/components/history_status.dart';

class HistoryBody extends StatefulWidget {
  const HistoryBody({super.key});

  @override
  State<HistoryBody> createState() => _HistoryBodyState();
}

class _HistoryBodyState extends State<HistoryBody> {
  final List<Map<String, dynamic>> historyStatus = [
    {
      'status': 'Hadir',
      'date': '12 Januari 2025',
      'checkIn': '07:00',
      'checkOut': '16:00',
      'color': const Color(0xFFE3F4E1),
      'statusColor': const Color(0xFF008000),
      'statusIcon': 'assets/images/icons/check.svg',
    },
    {
      'status': 'Izin',
      'date': '13 Januari 2025',
      'checkIn': '-',
      'checkOut': '-',
      'color': const Color(0xFFFAECD3),
      'statusColor': const Color(0xFF9E6D09),
      'statusIcon': 'assets/images/icons/permission.svg',
    },
    {
      'status': 'Sakit',
      'date': '14 Januari 2025',
      'checkIn': '-',
      'checkOut': '-',
      'color': const Color(0xFFF1D3D3),
      'statusColor': const Color(0xFFE81D1D),
      'statusIcon': 'assets/images/icons/sick.svg',
    },
    {
      'status': 'Cuti',
      'date': '15 Januari 2025',
      'checkIn': '-',
      'checkOut': '-',
      'color': const Color(0xFFD3EAFA),
      'statusColor': const Color(0xFF0095FF),
      'statusIcon': 'assets/images/icons/user.svg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // search produk
          const TextField(
            cursorColor: Colors.black12,
            decoration: InputDecoration(
              hintText: 'Cari',
              hintStyle: TextStyle(color: Colors.black12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              focusColor: Colors.grey,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black12),
              ),
              suffixIcon: Icon(Icons.search_sharp, color: Colors.grey),
              prefixStyle: TextStyle(color: Colors.black54),
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: historyStatus.length,
              itemBuilder: (context, index) {
                return HistoryStatus(
                  status: historyStatus[index]['status'],
                  date: historyStatus[index]['date'],
                  checkIn: historyStatus[index]['checkIn'],
                  checkOut: historyStatus[index]['checkOut'],
                  color: historyStatus[index]['color'],
                    statusColor: historyStatus[index]['statusColor'],
                  statusIcon: historyStatus[index]['statusIcon'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
