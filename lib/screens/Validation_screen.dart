import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class ValidationScreen extends StatefulWidget {
  ValidationScreen({Key? key}) : super(key: key);

  @override
  _ValidationScreenState createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  late String currentOs;
  void checkMyOs() {
    String os = Platform.operatingSystem;
    setState(() {
      currentOs = os;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 150, left: 20, right: 20),
              child: TextFormField(
                controller: emailController,
                validator: Platform.isAndroid
                    ? (email) {
                        if (email!.isEmpty) {
                          return 'This field is required';
                        }
                      }
                    : null,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.mail, color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.red),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'E-mail ID',
                  hintText: 'Enter Your Mail Id',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25, left: 20, right: 20),
              child: TextFormField(
                controller: passController,
                validator: Platform.isAndroid
                    ? (password) {
                        if (password!.isEmpty) {
                          return 'This field is required';
                        }
                      }
                    : null,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.password_rounded,
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
                  labelText: 'Password',
                  hintText: 'Enter Your Password',
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
                    // if (Platform.isAndroid) {
                    //   _formKey.currentState!.validate();
                    // } else {
                    if (Platform.isAndroid) {
                      if (emailController.text.isEmpty) {
                        alertBox();
                      } else
                        return null;
                    }
                    if (Platform.isAndroid) {
                      if (passController.text.isEmpty) {
                        alertBox();
                      } else
                        return null;
                    }
                  }
                  // }
                  ),
            ),
          ],
        ),
      )),
    ));
  }

  void alertBox() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("This field is Required")),
            actions: <Widget>[
              InkWell(
                  child: Center(child: Text("OK")),
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }
}
