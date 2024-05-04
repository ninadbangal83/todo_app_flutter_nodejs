import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {
  final Key? key;
  final String btnType;
  final String btnName;
  final Color? bgColor;
  final TextStyle? textStyle;
  final VoidCallback? handleClick;

  const CustomButtons({
    this.key,
    this.btnType = "elevated",
    required this.btnName,
    this.textStyle,
    this.bgColor,
    this.handleClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (btnType == "elevated") {
      return SizedBox(
        width: 200,
        child: ElevatedButton(
          onPressed: handleClick,
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
          ),
          child: Text(btnName, style: textStyle),
        ),
      );
    } else if (btnType == "text") {
      return SizedBox(
        width: 200,
        child: TextButton(
            onPressed: handleClick,
            style: TextButton.styleFrom(backgroundColor: bgColor),
            child: Text(btnName, style: textStyle)),
      );
    } else {
      return SizedBox(
        width: 200,
        child: OutlinedButton(
            onPressed: handleClick,
            style: OutlinedButton.styleFrom(backgroundColor: bgColor),
            child: Text(btnName, style: textStyle)),
      );
    }
  }
}
