import 'dart:async';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:project_testing/study_lock_utils/time_input_object.dart';

import 'package:flutter/material.dart';
import 'pomodoro_pause.dart';

import 'package:percent_indicator/percent_indicator.dart';

final Color topLabelColor = Colors.blueGrey;
final Color textColor = Colors.white70;
final Color bottomBoxColor = Colors.black12;

class Pomodoro extends StatefulWidget {
  final TimeInput input;

  @override
  _PomodoroState createState() => _PomodoroState(input);

  Pomodoro(this.input);
}

class _PomodoroState extends State<Pomodoro> {
  final TimeInput input;
  final audio = AudioCache();
  double percent = 0;
  int time = 0;
  int inputTime = 0;

  _PomodoroState(this.input) {
    inputTime = input.studyTime;
    _startTimer();
  }

  late Timer timer;

  void _startTimer() {
    time = inputTime * 60;
    int oldTime = inputTime * 60;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (time > 0) {
          time--;
          if (time % 60 == 0) {
            inputTime--;
          }
          percent = (oldTime - time) / oldTime;
        } else {
          audio.play('alert.mp3');
          percent = 0;
          inputTime = input.studyTime;
          timer.cancel();

          // STUDY TIMER REACHES 0
          if (input.cycle > 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PomodoroPause(
                  input.copy(cycle: input.cycle - 1),
                ),
              ),
            );
          } else {
            Navigator.pop(context);
          }
        }
      });
    });
  }

  Future<bool> _onBackPressed() async {
    if (time > 0) {
      final willpop = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Warning Timer has started"),
                actions: <Widget>[
                  TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text("back"))
                ],
              ));
      return willpop;
    } else {
      Navigator.pop(context);
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //       colors: [Colors.black, Colors.blueGrey],
            //       begin: FractionalOffset(0.5, 1)),
            // ),
            width: double.infinity,
            child: Stack(
              children: [
                Image.network(
                  'https://drive.google.com/uc?export=view&id=1gI-t4W4m3jBXnLdJ2_C30ZFwjVTdOLug',
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Container(
                      color: Colors.black,
                    );
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // TIMER LABEL
                    Padding(
                      padding: EdgeInsets.only(top: 25.0),
                      child: Text(
                        "Study Timer",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),

                    SizedBox(
                      height: 50.0,
                    ),

                    // COUNTDOWN CLOCK

                    CircularPercentIndicator(
                      percent: percent,
                      circularStrokeCap: CircularStrokeCap.round,
                      animation: true,
                      animateFromLastPercent: true,
                      radius: 200.0,
                      lineWidth: 20.0,
                      progressColor: Colors.white,
                      center: TextButton(
                        onPressed: () => audio.play('alert.mp3'),
                        child: Text(
                          '${minutesFormat(inputTime)}:${secondsFormat(time)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 60.0,
                          ),
                        ),
                      ),
                    ),

                    // BOTTOM BAR FOR TIME VALUES

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 30.0, left: 30.0, right: 20.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: 80.0,
                                          decoration: BoxDecoration(
                                            color: bottomBoxColor,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                          ),
                                          child: Column(children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.all(8.0),
                                              width: 80.0,
                                              decoration: BoxDecoration(
                                                color: topLabelColor,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    topRight:
                                                        Radius.circular(10.0)),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Study Timer",
                                                  style: TextStyle(
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: textColor),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "${input.studyTime}",
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: textColor),
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
                                            color: bottomBoxColor,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                          ),
                                          child: Column(children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.all(8.0),
                                              width: 80.0,
                                              decoration: BoxDecoration(
                                                color: topLabelColor,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    topRight:
                                                        Radius.circular(10.0)),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Break Timer",
                                                  style: TextStyle(
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: textColor),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "${input.pauseTime}",
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: textColor),
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
                                            color: bottomBoxColor,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                          ),
                                          child: Column(children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.all(8.0),
                                              width: 80.0,
                                              decoration: BoxDecoration(
                                                color: topLabelColor,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    topRight:
                                                        Radius.circular(10.0)),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Cycle",
                                                  style: TextStyle(
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: textColor),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "${input.cycle}",
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: textColor),
                                              ),
                                            )
                                          ]),
                                        ),
                                      ],
                                    ),

                                    // CANCEL BUTTON

                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 28.0),
                                      child: ElevatedButton(
                                          onPressed: () => showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: Text(
                                                      "Do you want to cancel study timer?"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text(
                                                        "yes",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                      onPressed: () {
                                                        timer.cancel();
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, false),
                                                        child: Text("no"))
                                                  ],
                                                ),
                                              ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.red, // background
                                              onPrimary: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
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
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
