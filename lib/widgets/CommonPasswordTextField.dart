import 'package:flutter/material.dart';

import '../utils/constant.dart';

class CommonPasswordTextField extends StatelessWidget {
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
  final bool obscurePassword;
  final bool error;
  final bool wrongError;

  const CommonPasswordTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.autocorrect = false,
      required this.text,
      required this.focus,
      required this.isFocused,
      required this.textColor,
      required this.hintColor,
      required this.textSize,
      required this.weight,
      required this.obscurePassword,
      required this.error,
      required this.wrongError})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.0,
        decoration: kEditTextDecoration,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: 40,
                  child: Image.asset(
                    "assets/password_icon.png",
                    color: Colors.grey,
                    scale: 3,
                  ),
                ),
              ),
              Flexible(
                flex: 8,
                child: TextFormField(
                  style: textStyle(textColor, textSize, 0.5, weight),
                  focusNode: focus,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: obscurePassword,
                  obscuringCharacter: '*',
                  enableSuggestions: false,
                  autocorrect: autocorrect,
                  controller: controller,
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
                    contentPadding:
                        const EdgeInsets.only(right: 40, bottom: 8, top: 8),
                  ),
                ),
              ),
            ]));
  }
}
