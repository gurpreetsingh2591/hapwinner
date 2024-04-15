import 'package:flutter/material.dart';
import '../utils/constant.dart';

class ReminderBoxWidget extends StatelessWidget {
  final String reminderName;
  final String id;
  final VoidCallback click;

  const ReminderBoxWidget({
    Key? key,
    required this.reminderName,
    required this.id,
    required this.click,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        click();
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 15, right: 15),
        decoration: kInnerDecoration,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [


          ],
        ),
      ),
    );
  }
}
