import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';

class SimDetectionScreen extends StatefulWidget {
  const SimDetectionScreen({Key? key}) : super(key: key);

  @override
  _SimDetectionScreenState createState() => _SimDetectionScreenState();
}

class _SimDetectionScreenState extends State<SimDetectionScreen> {
  List<SimCard> _simCard = <SimCard>[];
  String _mobileNumber1 = '';
  String _mobileNumber2 = '';
  @override
  void initState() {
    // List<dynamic> _simCards = ['a', true, 10];
    // _simCards.forEach((element) {
    //   print(element);
    // });
    // _simCard.forEach((element) {
    //   print(element.
    //   );
    // });

    super.initState();
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });

    initMobileNumberState();
  }

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    String mobileNumber = '';
    // String mobileNumbers = '';

    try {
      mobileNumber = (await MobileNumber.mobileNumber)!;
      _simCard = (await MobileNumber.getSimCards)!;
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    if (!mounted) return;

    setState(() {
      _mobileNumber1 = mobileNumber;
      // _mobileNumber2 = mobileNumbers;
    });
  }

  Widget dualCards() {
    List<Widget> widgets = _simCard
        .map((SimCard sim) => Text(
            'Sim Card Number: (${sim.countryPhonePrefix}) - ${sim.number}\n'))
        .toList();
    return Column(children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          // Container(
          //   margin: EdgeInsets.only(top: 100),
          //   child: Column(
          // children: <Widget>[
          //   dualCards(),
          Center(
        child: Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          height: 50,
          width: 200,
          color: Colors.orange,
          child: MaterialButton(
            onPressed: () {
              dualPopup(context);
            },
            child: Text(
              "Verify Mobile Number",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      //     ],
      //   ),
      // ),
    );
  }

  void dualPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Sim'),
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Container(
                width: double.maxFinite,
                height: 200,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _simCard.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          print('Selected Sim ${_simCard[index].number}');
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          child: Card(
                            elevation: 10,
                            margin: EdgeInsets.all(5),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Sim: ${index + 1}"),
                                          Text(
                                              'Mob no:${_simCard[index].number}'),
                                        ],
                                      ),
                                      Icon(
                                        Icons.sim_card,
                                        color: Colors.orange,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ]),
          );
        });
  }
}
