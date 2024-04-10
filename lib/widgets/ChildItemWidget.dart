import 'package:flutter/material.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import '../utils/constant.dart';


class ChildItemWidget extends StatelessWidget {
  final String name;
  final String momName;
  final String studentId;
  final bool visibility;
  final VoidCallback onTap;

  const ChildItemWidget({
    Key? key,
    required this.name,
    required this.momName,
    required this.studentId,
    required this.visibility,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: kMessageItemDecoration,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Image.asset(
                    "assets/icons/user.png",
                    scale: 5,
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          name,
                          textAlign: TextAlign.left,
                          style:
                              textStyle(Colors.black, 14, 0, FontWeight.w400),
                        ),
                      ),
                      5.height,
                      Text(
                        momName,
                        style:
                            textStyle(Colors.black87, 12, 0, FontWeight.w400),
                        textAlign: TextAlign.left,
                      ),
                      5.height,
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Visibility(
                    visible: visibility,
                    child: Image.asset(
                      "assets/images/paired_icon.png",
                      scale: 7,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            )));
  }
}
