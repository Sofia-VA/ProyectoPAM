import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final int iconID;
  final String iconFamily;
  final Color? iconColor;
  final Color? buttonColor;
  final double buttonSize;
  final VoidCallback? onButtonPressed;

  CustomIconButton({
    super.key,
    required this.iconID,
    required this.iconFamily,
    required this.buttonSize,
    this.iconColor,
    this.buttonColor,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: () {
          if (onButtonPressed != null) {
            onButtonPressed!();
          }
        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: const CircleBorder(),
            primary: buttonColor,
            fixedSize: Size(buttonSize, buttonSize)),
        child: SizedBox(
          width: double.infinity,
          child: Icon(
              IconData(
                0xf84a,
                fontFamily:
                    iconFamily, //'FontAwesomeSolid' or ''MaterialIcons'',
                fontPackage: iconFamily == 'FontAwesomeSolid'
                    ? 'font_awesome_flutter'
                    : null,
              ),
              size: buttonSize / 3,
              color: iconColor),
        ),
      ),
    );
  }
}
