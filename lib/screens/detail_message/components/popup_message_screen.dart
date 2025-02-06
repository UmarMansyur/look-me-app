import 'package:flutter/material.dart';
import 'message_bubble.dart';

class PopupMessageScreen extends StatelessWidget {
  const PopupMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        color: Colors.grey[50],
        child: SizedBox.expand(
          child: Column(
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
              Expanded(
                child: RawScrollbar(
                  thumbColor: Colors.blue[200],
                  radius: const Radius.circular(20),
                  thickness: 8,
                  thumbVisibility: true,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return MessageBubble(
                        index: index,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
