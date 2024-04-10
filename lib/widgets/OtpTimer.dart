import 'dart:async';

import 'package:flutter/material.dart';
import '../utils/constant.dart';


class OtpTimer extends StatefulWidget {
  final int timeInSec;
  final Function onTimerEnd;
  final GlobalKey<OtpTimerState> key;
  final Color textColor;
  final String extraText;
  final String frontText;

  const OtpTimer(
      {required this.timeInSec , required this.onTimerEnd, required this.key, required this.textColor, required this.extraText, required this.frontText})
      : super(key: key);

  @override
  OtpTimerState createState() => OtpTimerState();
}

class OtpTimerState extends State<OtpTimer> {
  late int currentSecond;
  late Timer timer;

  @override
  void initState() {
    currentSecond = widget.timeInSec;
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${widget.frontText}$currentSecond ${widget.extraText}',
      style: textStyle(widget.textColor, 16, 0, FontWeight.w400),
    );
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentSecond--;
      });
      if (currentSecond == 0) {
        stopTimer();
        widget.onTimerEnd();
      }
    });
  }

  void stopTimer() {
    timer.cancel();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  void restartTimer() {
    setState(() {
      currentSecond = widget.timeInSec;
    });
    startTimer();
  }
}
