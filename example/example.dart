import 'package:flutter/material.dart';
import 'package:password_validated_field/password_validated_field.dart';


/// Complete Simple Example
class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  // simple check
  bool _validPassword = false;

  // form key for validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Password Validated Field"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _validPassword
                ? Text(
                    "Password Valid!",
                    style: TextStyle(fontSize: 22.0),
                  )
                : Container(),
            PasswordValidatedFields(), // password validated field from package
            
            // Button to validate the form
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _validPassword = true;
                    });
                  } else {
                    setState(() {
                      _validPassword = false;
                    });
                  }
                },
                child: Text("Check password!")),
          ],
        ),
      ),
    );
  }
}
