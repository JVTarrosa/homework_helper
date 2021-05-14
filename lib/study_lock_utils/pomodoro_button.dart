import 'package:flutter/material.dart';
import 'time_picker.dart';

class PomodoroButton extends StatelessWidget {
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
            Text('Pomodoro mode',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ]),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => NumPicker()));
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.blue, // background
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0)) // foreground
          ),
        ));
    // ),
  }
}