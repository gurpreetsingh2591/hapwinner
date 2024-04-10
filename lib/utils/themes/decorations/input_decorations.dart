import 'package:flutter/material.dart';


import '../theme_text_styles.dart';

InputDecoration defaultInputDecoration(
    {String? hint, String? label, TextStyle? textStyle}) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    hintStyle: textStyle ?? primaryTextStyle(),
    labelStyle: textStyle ?? secondaryTextStyle(),
    border: const OutlineInputBorder(),
    alignLabelWithHint: true,
  );
}
