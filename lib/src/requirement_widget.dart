import 'package:flutter/material.dart';

class PassCheckRequirements extends StatelessWidget {
  final bool? passCheck;
  final String? requirementText;
  final IconData? activeIcon;
  final IconData? inActiveIcon;

  final Color? inActiveColor;
  final Color? activeColor;

  PassCheckRequirements({
    Key? key,
    @required this.passCheck,
    @required this.requirementText,
    this.inActiveIcon = Icons.check_circle_outline_rounded,
    this.activeIcon = Icons.check_circle_rounded,
    this.inActiveColor = Colors.grey,
    this.activeColor = Colors.blue,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.5),
      child: Row(
        children: [
          passCheck!
              ? Icon(Icons.check_circle_rounded, color: activeColor)
              : Icon(Icons.check_circle_outline_rounded, color: inActiveColor),
          SizedBox(width: 8.0),
          Text(
            requirementText!,
            style: TextStyle(
              color: passCheck! ? activeColor : inActiveColor,
            ),
          )
        ],
      ),
    );
  }
}
