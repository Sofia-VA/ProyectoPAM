import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final int iconID;
  final Color? iconColor;
  final Color? buttonColor;
  final buttonPressed;

  CustomIconButton({
    super.key,
    required this.iconID,
    this.iconColor,
    this.buttonColor,
    this.buttonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: () {
          buttonPressed();
        },
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            primary: buttonColor,
            fixedSize: const Size(60, 60)),
        child: Icon(
            IconData(
              0xf84a,
              fontFamily: 'FontAwesomeSolid',
              fontPackage: 'font_awesome_flutter',
            ),
            size: 26,
            color: iconColor),
      ),
    );
  }
}
