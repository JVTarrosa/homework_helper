import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:project_testing/study_lock_utils/time_input_object.dart';

class TimeSelectors extends StatefulWidget {
  final TimeInput input;

  const TimeSelectors({required this.input, Key? key}) : super(key: key);

  @override
  _TimeSelectorsState createState() => _TimeSelectorsState(input: input);
}

class _TimeSelectorsState extends State<TimeSelectors> {
  final TimeInput input;

  _TimeSelectorsState({required this.input});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //SET STUDY TIME

        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
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
                      color: Theme.of(context).primaryColor),
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

        //SET PAUSE TIME

        Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
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
                        color: Theme.of(context).primaryColor),
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

        // SET CYCLES

        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
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
                      color: Theme.of(context).primaryColor),
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
      ],
    );
  }
}
