import 'package:flutter/material.dart';
import 'package:project_testing/study_lock_utils/time_input_object.dart';
import 'pomodoro_timer.dart';

class TimerButton extends StatelessWidget {
  String? buttonName;
  final TimeInput timeInput;

  TimerButton({required this.timeInput}) {
    buttonName = timeInput.name;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              buttonName ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: buttonName!.length < 20 ? 25 : 18,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
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
                    color: Theme.of(context).focusColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                  ),
                  child: Center(
                    child: Text(
                      "Study Time",
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${timeInput.studyTime}",
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
                    color: Theme.of(context).focusColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                  ),
                  child: Center(
                    child: Text(
                      "Break Time",
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${timeInput.pauseTime}",
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
                    color: Theme.of(context).focusColor,
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
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${timeInput.cycle}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                )
              ]),
            ),
          ],
        ),
      ]),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Pomodoro(timeInput)));
      },
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).accentColor, // background
        onPrimary: Theme.of(context).primaryColor, // foreground
      ),
    );
    // ),
  }
}
