import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_me/screens/permission/components/status_card.dart';

class PermissionStatus extends StatelessWidget {
  const PermissionStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/icons/calendar.svg',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(_getFormattedDate(index), style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),),
                ],
              ),
              const SizedBox(height: 10),
              const StatusCard(
                title: 'Permohonan Izin',
                description: 'Perjalanan dinas keluar kota untuk 3 hari',
                detail: 'lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
                date: '29',
                day: 'Senin',
                status: 'Menunggu Konfirmasi',
                statusColor: Colors.white,
                statusTextColor: Color(0xFF9E6D09),
                backgroundColor: Color(0xFFFAECD3),
              ),
              const StatusCard(
                title: 'Permohonan Izin (Sakit)',
                description: 'Sakit kepala',
                detail: 'Mohon maaf, saya tidak dapat bekerja karena sakit kepala',
                date: '01',
                day: 'Selasa',
                status: 'Disetujui',
                statusColor: Colors.white,
                statusTextColor: Color(0xFF3EA03C),
                backgroundColor: Color(0xFFD3F1D2),
              ),
              const StatusCard(
                title: 'Permohonan Izin',
                description: 'Mancing di laut',
                detail: 'Mohon maaf, saya tidak dapat bekerja karena mancing di laut',
                date: '02',
                day: 'Rabu',
                status: 'Ditolak',
                statusColor: Colors.white,
                statusTextColor: Color(0xFFE81D1D),
                backgroundColor: Color(0xFFF1D3D3),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getFormattedDate(int index) {
    final now = DateTime.now();
    final date = DateTime(now.year, now.month + index);
    return '${_getIndonesianMonth(date.month)} ${date.year}';
  }

  String _getIndonesianMonth(int month) {
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return months[month - 1];
  }
}
