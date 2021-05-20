import 'package:flutter/material.dart';
import 'package:project_testing/study_lock_utils/time_input_object.dart';
import 'study_timer.dart';

class PomodoroButton extends StatelessWidget {
  final TimeInput timeInput;
  
  PomodoroButton({required this.timeInput});
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 50.0,
      child: ElevatedButton(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.lock_clock,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text('Improvise Timer',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ]),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Pomodoro(timeInput)));
        },
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).accentColor, // background
            onPrimary: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0)) // foreground
            ),
      ),
    );
    // ),
  }
}
