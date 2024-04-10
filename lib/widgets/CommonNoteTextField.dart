import 'package:flutter/material.dart';

import '../utils/constant.dart';

class CommonNoteTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focus;
  final String hintText;
  final bool autocorrect;
  final String text;
  final bool isFocused;
  final Color textColor;
  final Color hintColor;
  final double textSize;
  final FontWeight weight;
  final bool error;
  final bool wrongError;
  final BoxDecoration decoration;
  final double padding;

  const CommonNoteTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.autocorrect = false,
    required this.text,
    required this.isFocused,
    required this.textColor,
    required this.focus,
    required this.textSize,
    required this.weight,
    required this.hintColor,
    required this.error,
    required this.wrongError,
    required this.decoration,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 150.0 * MediaQuery.of(context).textScaleFactor,

        // You can adjust the width and decoration as needed
        decoration: decoration,
        child: TextFormField(
          style: textStyle(textColor, textSize, 0.5, weight),
          focusNode: focus,
          keyboardType: TextInputType.emailAddress,
          enableSuggestions: false,
          autocorrect: autocorrect,
          controller: controller,
          maxLength: 300,
          cursorColor: Colors.black,
          cursorWidth: 1,
          autofocus: false,
          textAlign: TextAlign.left,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            border: InputBorder.none,
            counterText: '',
            hintStyle: hintStyle(hintColor, textSize, 0.5, weight),
            hintText: hintText,
            contentPadding:  EdgeInsets.only(
                left: padding, right: 16, top: 8, bottom: 8),
          ),
        ),
      ),
    );
  }
}
