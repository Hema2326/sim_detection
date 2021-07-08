import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_error/screens/Validation_screen.dart';

class MobileNoValidation extends StatefulWidget {
  const MobileNoValidation({Key? key}) : super(key: key);

  @override
  _MobileNoValidationState createState() => _MobileNoValidationState();
}

class _MobileNoValidationState extends State<MobileNoValidation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController mobNoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 250, left: 20, right: 20),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                autocorrect: true,
                maxLength: 12,
                controller: mobNoController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                    RegExp((r'[0-9]')),
                  )
                ],
                validator: validators,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.phone_iphone,
                    color: Colors.blue,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.red),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Mobile Number',
                  hintText: 'Enter Your Mobile Number',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.antiAlias,
                height: 45,
                color: Colors.blue,
                animationDuration: Duration(seconds: 10),
                minWidth: 200,
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ValidationScreen()));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? validators(value) {
    String pattern =
        r'(\+91)?(-)?\s*?(91)?\s*?(\d{​​​​​​​​3}​​​​​​​​)-?\s*?(\d{​​​​​​​​3}​​​​​​​​)-?\s*?(\d{​​​​​​​​4}​​​​​​​​)';
    RegExp regExp = new RegExp(pattern);

    if (value.length == 0) {
      return 'Mobile can\'t be empty';
    } else if (!regExp.hasMatch(value)) {
      return 'Enter the Valid Number';
    }
  }
}
