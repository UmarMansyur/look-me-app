import 'package:flutter/material.dart';
// import 'message_bubble.dart';

class PopupMessageScreen extends StatelessWidget {
  final String detailMessage;
  const PopupMessageScreen({super.key, required this.detailMessage});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        color: Colors.grey[50],
        child: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                  vertical: 4,
                ),
                child: Text(
                  '12 Januari 2025',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              ],
              ),

              // Enhanced message bubble with better styling
              Container(
                
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(20),
                  ),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Text(
                  detailMessage,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    height: 1.5,
                    color: Colors.black87,
                    letterSpacing: 0.3,
                  ),
                ),
              ),



              // Expanded(
              //   child: RawScrollbar(
              //     thumbColor: Colors.blue[200],
              //     radius: const Radius.circular(20),
              //     thickness: 8,
              //     thumbVisibility: true,
              //     child: ListView.builder(
              //       physics: const BouncingScrollPhysics(),
              //       itemCount: 3,
              //       itemBuilder: (context, index) {
              //         return MessageBubble(
              //           index: index,
              //         );
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
