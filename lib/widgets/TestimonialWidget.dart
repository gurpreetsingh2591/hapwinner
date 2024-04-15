import 'package:flutter/material.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import '../utils/constant.dart';
import 'ChildItemWidget.dart';

class TestimonialWidget extends StatelessWidget {
  final BoxDecoration decoration;
  final String name;
  final String testimonial;
  final String image;
  final VoidCallback onTap;

  const TestimonialWidget({
    Key? key,
    required this.onTap,
    required this.decoration,
    required this.name,
    required this.testimonial,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(20),
        decoration: kAllCornerBoxDecoration,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Flexible(
            flex: 1,
            child: Column(children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(image),
              ),
              15.height,
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: textStyle(Colors.white, 18, 0, FontWeight.w500),
                ),
              ),
            ]),
          ),
          15.width,
          Flexible(
            flex: 3,
            child: Column(children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  testimonial,
                  textAlign: TextAlign.left,
                  style: textStyle(Colors.white, 14, 0, FontWeight.w400),
                ),
              ),
            ]),
          ),
        ]));
  }
}
