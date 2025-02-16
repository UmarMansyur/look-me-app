import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_me/components/avatar.dart';
import 'package:look_me/store/session.dart';
import 'package:provider/provider.dart';

class HistoryCard extends StatefulWidget {
  final List<dynamic> history;
  const HistoryCard({super.key, required this.history});

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  TextStyle textStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  Widget _buildHistoryItem(Map<String, dynamic> item) {
    final session = Provider.of<SessionStore>(context, listen: false);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.black.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Avatar(
                    backgroundColor: Colors.grey,
                    imageUrl: session.user['thumbnail'] ??
                        'https://ik.imagekit.io/8zmr0xxik/Colorful_Gradient_Background_Man_3D_Avatar_4F0kSVV0X.png?updatedAt=1709258633386',
                    radius: 20,
                    borderColor: Colors.white,
                    width: 30,
                    height: 30,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        session.user['username'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        session.user['email'],
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAECD3),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  item['tanggal'],
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFFD3B16B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0A3C40), Color(0xFF116256)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 5,
                  left: 10,
                  child: SvgPicture.asset(
                    'assets/images/icons/square.svg',
                    width: 70,
                    height: 70,
                  ),
                ),
                Positioned(
                  bottom: 6,
                  right: 10,
                  child: SvgPicture.asset(
                    'assets/images/icons/square2.svg',
                    width: 70,
                    height: 70,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("Check In", style: textStyle),
                          Text(
                            item['check_in'] ?? '-',
                            style: textStyle.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.white,
                      ),
                      Column(
                        children: [
                          Text("Check Out", style: textStyle),
                          Text(
                            item['check_out'] ?? '-',
                            style: textStyle.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Riwayat Kehadiran',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF063039),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                color: Color(0xFF063039),
              ),
            ),
          ],
        ),
        // ignore: unnecessary_to_list_in_spreads
        ...widget.history.map((item) => _buildHistoryItem(item)).toList(),
      ],
    );
  }
}
