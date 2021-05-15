import 'package:flutter/material.dart';
import 'package:project_testing/study_lock_utils/time_input.dart';
import 'study_timer.dart';
import 'package:numberpicker/numberpicker.dart';

class NumPicker extends StatefulWidget {
  @override
  _NumPickerState createState() => _NumPickerState();
}

class _NumPickerState extends State<NumPicker> {
  TimeInput input = TimeInput(studyTime: 0, pauseTime: 0, cycle: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Study Lock"),
      ),
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0))),
                          height: 30.0,
                          width: 100.0,
                          child: Center(
                            child: Text(
                              "Study Time",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              )),
                          height: 150.0,
                          child: NumberPicker(
                            value: input.studyTime,
                            minValue: 0,
                            maxValue: 1440,
                            onChanged: (val) {
                              setState(() {
                                input.studyTime = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0))),
                            height: 30.0,
                            width: 100.0,
                            child: Center(
                              child: Text(
                                "Pause Time",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            )),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                          ),
                          height: 150.0,
                          child: NumberPicker(
                            value: input.pauseTime,
                            minValue: 0,
                            maxValue: 120,
                            onChanged: (val) {
                              setState(() {
                                input.pauseTime = val;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0))),
                          height: 30.0,
                          width: 100.0,
                          child: Center(
                            child: Text(
                              "Cycle",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              )),
                          height: 150.0,
                          child: NumberPicker(
                            value: input.cycle,
                            minValue: 0,
                            maxValue: 24,
                            onChanged: (val) {
                              setState(() {
                                input.cycle = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ]),
              SizedBox(
                height: 300.0,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // background
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 20.0), // foreground
                  ),
                  child: Text("Start",
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Pomodoro(input)));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
