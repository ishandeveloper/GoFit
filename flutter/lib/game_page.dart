import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:firebase_database/firebase_database.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final databaseReference = FirebaseDatabase.instance.reference();
  double x, y, z;
  double last = 0.0,
      second = 0.0,
      third = 0.0,
      fourth = 0.0,
      fifth = 0.0,
      sixth = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
      });
    }); //get the sensor data and set then to the data types
  }

  void realtimeUpdateAction(int action) {
    databaseReference
        .child('628710')
        .update({'actions': '$action${DateTime.now().millisecondsSinceEpoch}'});
  }

  void createData() {
    databaseReference.child('628710').set({
      'actions': '${0}${DateTime.now().millisecondsSinceEpoch}',
      'code': 628710,
    });
  }

  @override
  Widget build(BuildContext context) {
    sixth = fifth;
    fifth = fourth;
    fourth = third;
    third = second;
    second = last;
    last = z;

    //Jump
    if (y > 15) {
      print("Jumped");
      realtimeUpdateAction(0);
    }
    //Left
    if (third < 0) {
      if (last > (sixth * 2)) {
        print("left");
        realtimeUpdateAction(1);
      }
    }
    //Right
    if (fifth > (sixth * 1.3)) {
      if (fourth < 0.5 || third < 0.5 || second < 0.5 || last < 0.5) {
        print("right");
        realtimeUpdateAction(2);
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Sensor Library"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Position",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
                ),
              ),
              Table(
                border: TableBorder.all(
                    width: 2.0,
                    color: Colors.blueAccent,
                    style: BorderStyle.solid),
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "X Asis : ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            x.toStringAsFixed(
                                2), //trim the asis value to 2 digit after decimal point
                            style: TextStyle(fontSize: 20.0)),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Y Asis : ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            y.toStringAsFixed(
                                2), //trim the asis value to 2 digit after decimal point
                            style: TextStyle(fontSize: 20.0)),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Z Asis : ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            z.toStringAsFixed(
                                2), //trim the asis value to 2 digit after decimal point
                            style: TextStyle(fontSize: 20.0)),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              FlatButton(
                height: 100,
                minWidth: 300,
                color: Colors.red,
                onPressed: () {
                  // createData();
                  realtimeUpdateAction(0);
                  print("create");
                },
                child: Text("Flag"),
              ),
            ],
          ),
        ));
  }
}
