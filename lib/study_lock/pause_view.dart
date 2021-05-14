import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:project_testing/study_lock/study_timer.dart';

class PomodoroPause extends StatefulWidget {
  final int minutInput;
  final int pauseTime;
  final int cycle;
  @override
  _PomodoroPauseState createState() =>
      _PomodoroPauseState(minutInput, pauseTime, cycle);

  PomodoroPause(this.minutInput, this.pauseTime, this.cycle);
}

class _PomodoroPauseState extends State<PomodoroPause> {
  double percent = 0;
  int timeInMinut = 0;
  int time = 0;

  int inputTime;
  int pauseTime;
  int cycle;

  _PomodoroPauseState(this.timeInMinut, this.pauseTime, this.cycle) {
    inputTime = timeInMinut;
    _startTimer();
  }

  Timer timer;

  void _startTimer() {
    time = timeInMinut * 60;
    int oldTime = timeInMinut * 60;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (time > 0) {
          time--;
          if (time % 60 == 0) {
            timeInMinut--;
          }
          percent = (oldTime - time) / oldTime;
        } else {
          percent = 0;
          timeInMinut = inputTime;
          timer.cancel();

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Pomodoro(inputTime, pauseTime, cycle)));
        }
      });
    });
  }

  Future<bool> _onBackPressed() {
    if (time > 0)
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Warning Timer has stated"),
                actions: <Widget>[
                  TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text("back"))
                ],
              ));
    else {
      Navigator.pop(context);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
            body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black, Colors.blueGrey],
                      begin: FractionalOffset(0.5, 1)),
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 25.0),
                      child: Text(
                        "Pause",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 40.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Expanded(
                      child: CircularPercentIndicator(
                        percent: percent,
                        circularStrokeCap: CircularStrokeCap.round,
                        animation: true,
                        animateFromLastPercent: true,
                        radius: 250.0,
                        lineWidth: 20.0,
                        progressColor: Colors.green,
                        // backgroundColor: Colors.green,
                        center: Text(
                          "$timeInMinut",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 80.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    SizedBox(
                      height: 30.0,
                      child: Text("$time"),
                    ),
                    SizedBox(
                      height: 100.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        // color: Colors.lightBlue[50],
                        // color: Colors.white,
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 30.0, left: 30.0, right: 20.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 80.0,
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Column(children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        width: 80.0,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Study Timer",
                                            style: TextStyle(
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "$inputTime",
                                          style: TextStyle(fontSize: 20.0),
                                        ),
                                      )
                                    ]),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Container(
                                    width: 80.0,
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Column(children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        width: 80.0,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Pause Timer",
                                            style: TextStyle(
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "$pauseTime",
                                          style: TextStyle(fontSize: 20.0),
                                        ),
                                      )
                                    ]),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Container(
                                    width: 80.0,
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Column(children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        width: 80.0,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Cycle",
                                            style: TextStyle(
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "$cycle",
                                          style: TextStyle(fontSize: 20.0),
                                        ),
                                      )
                                    ]),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 28.0),
                                child: ElevatedButton(
                                    onPressed: () =>
                                        // Navigator.pop(context, true),
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text(
                                                      "Do you want to cancel study timer?"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                        child: Text(
                                                          "yes",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                        }),
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, false),
                                                        child: Text("no"))
                                                  ],
                                                )),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red, // background
                                        onPrimary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                100.0)) // foreground
                                        ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }
}
