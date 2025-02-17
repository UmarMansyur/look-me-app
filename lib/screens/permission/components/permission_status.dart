import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_me/screens/permission/components/status_card.dart';

class PermissionStatus extends StatefulWidget {
  final List<Map<String, dynamic>> permissions;
  const PermissionStatus({super.key, required this.permissions});

  @override
  State<PermissionStatus> createState() => _PermissionStatusState();
}

class _PermissionStatusState extends State<PermissionStatus> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.permissions.length,
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
                  Text(
                    widget.permissions[index]['month'],
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ...widget.permissions[index]['value'].map((permission) {
                if (permission['status'] == 'Pending') {
                  return StatusCard(
                    title: permission['header'],
                    description: permission['title'],
                    detail: permission['desc'] ?? '',
                    date: permission['date'].toString(),
                    day: permission['day'],
                    startDate: permission['start_date'].toString(),
                    endDate: permission['end_date'].toString(),
                    status: 'Menunggu Konfirmasi',
                    reason: permission['reason'] ?? '',
                    statusColor: Colors.white,
                    statusTextColor: const Color(0xFF9E6D09),
                    backgroundColor: const Color(0xFFFAECD3),
                  );
                }
                if (permission['status'] == 'Approved') {
                  return StatusCard(
                    title: permission['header'],
                    description: permission['title'],
                    detail: permission['desc'] ?? '',
                    date: permission['date'].toString(),
                    day: permission['day'],
                    startDate: permission['start_date'].toString(),
                    endDate: permission['end_date'].toString(),
                    status: 'Disetujui',
                    reason: permission['reason'] ?? '',
                    statusColor: Colors.white,
                    statusTextColor: const Color(0xFF3EA03C),
                    backgroundColor: const Color(0xFFD3F1D2),
                  );
                }
                if (permission['status'] == 'Rejected') {
                  return StatusCard(
                    title: permission['header'],
                    description: permission['title'],
                    detail: permission['desc'] ?? '',
                    date: permission['date'].toString(),
                    day: permission['day'],
                    startDate: permission['start_date'].toString(),
                    endDate: permission['end_date'].toString(),
                    status: 'Ditolak',
                    reason: permission['reason'] ?? '',
                    statusColor: Colors.white,
                    statusTextColor: const Color(0xFFE81D1D),
                    backgroundColor: const Color(0xFFF1D3D3),
                  );
                }
              }),
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
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return months[month - 1];
  }
}
