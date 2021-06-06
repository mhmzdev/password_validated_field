import 'package:flutter/material.dart';
import 'package:password_validated_field/src/requirement_widget.dart';

class PasswordValidatedFields extends StatefulWidget {
  final List<PassCheckRequirements>? moreRequirements;
  final InputDecoration? inputDecoration;
  final TextEditingController? textEditingController;
  final TextInputAction? textInputAction;
  final void Function()? onEditComplete;
  final String Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final Color? cursorColor;
  final TextStyle? textStyle;
  // Password requirements
  final IconData? activeIcon;
  final IconData? inActiveIcon;
  final Color? activeRequirementColor;
  final Color? inActiveRequirementColor;
  PasswordValidatedFields({
    Key? key,
    this.moreRequirements,
    this.inputDecoration = const InputDecoration(
        hintText: "Enter password",
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder()),
    this.textEditingController,
    this.textInputAction = TextInputAction.done,
    this.onEditComplete,
    this.onFieldSubmitted,
    this.focusNode,
    this.cursorColor,
    this.textStyle,
    // Password requirements initialization
    this.inActiveIcon = Icons.check_circle_outline_rounded,
    this.activeIcon = Icons.check_circle_rounded,
    this.inActiveRequirementColor = Colors.grey,
    this.activeRequirementColor = Colors.blue,
  }) : super(key: key);

  @override
  _PasswordValidatedFieldsState createState() =>
      _PasswordValidatedFieldsState();
}

class _PasswordValidatedFieldsState extends State<PasswordValidatedFields> {
  bool _moreRequirements = false;
  String _pass = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
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
          PassCheckRequirements(
            passCheck: _pass.contains(RegExp(r'[A-Z]')),
            requirementText: "1 Uppercase [A-Z]",
          ),
          PassCheckRequirements(
            passCheck: _pass.contains(RegExp(r'[a-z]')),
            requirementText: "1 lowercase [a-z]",
          ),
          PassCheckRequirements(
            passCheck: _pass.contains(RegExp(r'[0-9]')),
            requirementText: "1 numeric value [0-9]",
          ),
          PassCheckRequirements(
            passCheck: _pass.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
            requirementText: "1 special character [#, \$, % etc..]",
          ),
          PassCheckRequirements(
            passCheck: _pass.length >= 6,
            requirementText: "6 characters minimum",
          ),
          _generateMoreRequirements()
        ],
      ),
    );
  }

  String? passwordValidation(String? value) {
    bool passValid =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
        .hasMatch(value!);
    if (value.isEmpty) {
      return "Password cannot be emtpy!";
    } else if (!passValid) {
      return "Requirement(s) missing!";
    }
    return null;
  }

  bool _hasMoreRequirements() {
    _moreRequirements = widget.moreRequirements == null ? false : true;
    return _moreRequirements;
  }

  Widget _generateMoreRequirements() {
    if (_hasMoreRequirements()) {
      for (int i = 0; i < widget.moreRequirements!.length; i++) {
        return widget.moreRequirements![i];
      }
    }
    return Container();
  }
}
