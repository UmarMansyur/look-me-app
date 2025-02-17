import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final String title;
  final String description;
  final String detail;
  final String date;
  final String status;
  final Color statusColor;
  final Color statusTextColor;
  final String day;
  final Color backgroundColor;
  final String startDate;
  final String endDate;
  final String reason;
  const StatusCard(
      {super.key,
      required this.title,
      required this.description,
      required this.detail,
      required this.date,
      required this.status,
      required this.statusColor,
      required this.statusTextColor,
      required this.day,
      required this.backgroundColor,
      required this.startDate,
      required this.endDate,
      required this.reason});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            // berikan min width 60 dan min height 80
            constraints: const BoxConstraints(
              minWidth: 70,
              minHeight: 80,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: statusTextColor,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  day,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: statusTextColor,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 6,
                          fontWeight: FontWeight.w400,
                          color: statusTextColor,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '$startDate - $endDate',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  detail,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // jika alasan ada maka tampilkan alasan
                if (reason.isNotEmpty)
                  Text(
                    'Alasan: $reason',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
