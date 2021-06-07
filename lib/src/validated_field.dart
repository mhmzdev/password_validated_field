import 'package:flutter/material.dart';
import 'package:password_validated_field/src/requirement_widget.dart';

class PasswordValidatedFields extends StatefulWidget {
  
  /// Password `validation` is given at the bottom which can be `modified` accordingly.
  /// Full package can be modified easily
  

  /// Input decoration of Text field by default it is OutlineInputBorder
  final InputDecoration? inputDecoration;

  /// textEditingController for the field
  final TextEditingController? textEditingController;

  /// textInputAction for the field. By default its set to [done]
  final TextInputAction? textInputAction;

  /// onEditComplete callBack for the field
  final void Function()? onEditComplete;

  /// onFieldSubmitted callBack for the field
  final String Function(String)? onFieldSubmitted;

  /// focusNode for the field
  final FocusNode? focusNode;

  /// cursorColor
  final Color? cursorColor;

  /// textStyle of the Text in field
  final TextStyle? textStyle;

  /// Password requirements attributes
  /// iconData for the icons when requirement is completed
  final IconData? activeIcon;

  /// iconData for the icons when the requirement is incomplete/inActive
  final IconData? inActiveIcon;

  /// color of the text when requirement is completed
  final Color? activeRequirementColor;

  /// color of the text when the requirement is not completed/inActive
  final Color? inActiveRequirementColor;

  /// Constructor
  PasswordValidatedFields({
    Key? key,

    /// [default inputDecoration]
    this.inputDecoration = const InputDecoration(
        hintText: "Enter password",
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder()),
    this.textEditingController,

    /// [default textInputAction]
    this.textInputAction = TextInputAction.done,
    this.onEditComplete,
    this.onFieldSubmitted,
    this.focusNode,
    this.cursorColor,
    this.textStyle,

    /// Password requirements initialization
    /// [default inActiveIcon]
    this.inActiveIcon = Icons.check_circle_outline_rounded,

    /// [default activeIcon]
    this.activeIcon = Icons.check_circle_rounded,

    /// [default inActive Color]
    this.inActiveRequirementColor = Colors.grey,

    /// [default active color]
    this.activeRequirementColor = Colors.blue,
  }) : super(key: key);

  @override
  _PasswordValidatedFieldsState createState() =>
      _PasswordValidatedFieldsState();
}

class _PasswordValidatedFieldsState extends State<PasswordValidatedFields> {
  String _pass = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [

          /// [Password TextFormField]
          /// Use `Form` to validate the field easily
          TextFormField(
            textInputAction: widget.textInputAction,
            controller: widget.textEditingController,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: widget.inputDecoration,
            onEditingComplete: widget.onEditComplete,
            onFieldSubmitted: widget.onFieldSubmitted,
            focusNode: widget.focusNode,
            cursorColor: widget.cursorColor,
            style: widget.textStyle,
            onChanged: (value) {
              setState(() {
                _pass = value;
                print(_pass);
              });
            },
            validator: passwordValidation,
          ),
          SizedBox(height: 10.0),

          /// [default requirements]
          /// `1 Upper case` requirement
          PassCheckRequirements(
            passCheck: _pass.contains(RegExp(r'[A-Z]')),
            requirementText: "1 Uppercase [A-Z]",
          ),

          /// `1 lowercase` requirement
          PassCheckRequirements(
            passCheck: _pass.contains(RegExp(r'[a-z]')),
            requirementText: "1 lowercase [a-z]",
          ),

          /// `1 numeric value` requirement
          PassCheckRequirements(
            passCheck: _pass.contains(RegExp(r'[0-9]')),
            requirementText: "1 numeric value [0-9]",
          ),

          /// `1 special character` requirement
          PassCheckRequirements(
            passCheck: _pass.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
            requirementText: "1 special character [#, \$, % etc..]",
          ),

          /// `6 character length` requirement
          PassCheckRequirements(
            passCheck: _pass.length >= 6,
            requirementText: "6 characters minimum",
          ),
        ],
      ),
    );
  }


  /// [password validation]
  /// 1 Uppercase
  /// 1 lowercase
  /// 1 numeric value
  /// 1 special character
  /// 6 length password
  
  /// In case you want to `modify` the requirements change the `RegExp` given below
  String? passwordValidation(String? value) {
    bool passValid =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$') /// [RegExp]
            .hasMatch(value!);
    if (value.isEmpty) {
      return "Password cannot be emtpy!";
    } else if (!passValid) {
      return "Requirement(s) missing!";
    }
    return null;
  }
}
