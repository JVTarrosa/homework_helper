import 'package:flutter/material.dart';
import 'package:project_testing/study_lock_utils/time_input_object.dart';
import 'study_timer.dart';
import 'package:numberpicker/numberpicker.dart';
import 'time_selectors.dart';

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

              // TIME SELECTORS
              TimeSelectors(input: input),

              SizedBox(
                height: 300.0,
              ),

              // START BUTTON

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
