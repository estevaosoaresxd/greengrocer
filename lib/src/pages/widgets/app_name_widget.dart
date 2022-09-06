import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class AppNameWidget extends StatelessWidget {
  final Color? greenTitleColor;
  final double textSize;
  final bool fontWeight;
  const AppNameWidget({
    Key? key,
    this.greenTitleColor,
    this.textSize = 30,
    this.fontWeight = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: textSize,
          fontWeight: fontWeight ? FontWeight.w500 : FontWeight.normal,
        ),
        children: [
          TextSpan(
            text: "Green",
            style: TextStyle(
                color: greenTitleColor ?? CustomColors.customSwatchColors),
          ),
          TextSpan(
              text: "grocer",
              style: TextStyle(
                color: CustomColors.customConstrastColors,
                fontWeight: FontWeight.normal,
              )),
        ],
      ),
    );
  }
}
