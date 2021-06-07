import 'package:flutter/material.dart';

class PassCheckRequirements extends StatelessWidget {

  /// a `bool` value as check [required] field in case you want to `modify` the package
  final bool? passCheck;

  /// requirement text [required] field in case you want to `modify` the package
  final String? requirementText;

  /// IconData when requirement is completed
  final IconData? activeIcon;

  /// IconData when requirement is not completed/inActive
  final IconData? inActiveIcon;

  /// inActive color
  final Color? inActiveColor;

  /// Active color
  final Color? activeColor;

  PassCheckRequirements({
    Key? key,
    @required this.passCheck, /// [required parameters] in case you want to modify the package
    @required this.requirementText, /// [required parameters] in case you want to modify the package

    /// [default] value of in-active IconData
    this.inActiveIcon = Icons.check_circle_outline_rounded,

    /// [default] value of active IconData
    this.activeIcon = Icons.check_circle_rounded,

    /// [default] color of in-active field
    this.inActiveColor = Colors.grey,

    /// [default] color of active field
    this.activeColor = Colors.blue,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.5),
      child: Row(
        children: [

          /// requirement IconData based on check!
          passCheck!
              ? Icon(Icons.check_circle_rounded, color: activeColor)
              : Icon(Icons.check_circle_outline_rounded, color: inActiveColor),
          SizedBox(width: 8.0),

          /// requirement text
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
