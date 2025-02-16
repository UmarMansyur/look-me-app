// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InformationCard extends StatefulWidget {
  final List<Map<String, String>> informationCard;
  const InformationCard({super.key, required this.informationCard});

  @override
  State<InformationCard> createState() => _InformationCardState();
}

class _InformationCardState extends State<InformationCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.informationCard
              .map((item) => Container(
                    width: MediaQuery.of(context).size.width * 0.48,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.1),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(item['icon'] ?? ''),
                            const SizedBox(width: 10),
                            Text(
                              item['title'] ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              item['amount'] ?? '0',
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0B3D41),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                'hari',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0B3D41),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
