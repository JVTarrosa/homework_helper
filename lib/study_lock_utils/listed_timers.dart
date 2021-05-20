import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'time_input_object.dart';
import 'package:intl/intl.dart';
import 'package:project_testing/database/time_input_operations.dart';
import 'listed_timer_button.dart';

class SavedTimerList extends StatelessWidget {
  List<TimeInput>? savedTimers;

  SavedTimerList(this.savedTimers, {Key? key}) : super(key: key);
  TimeInputOperations timeInputOperations = TimeInputOperations();

  @override
  Widget build(BuildContext context) {
    return savedTimers!.isEmpty
        ? Container(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      '(No Timers Saved)',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          )
        : Column(children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: savedTimers!.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  secondaryBackground: Container(
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  child: TimerButton(timeInput: savedTimers![index]),
                  onDismissed: (direction) {
                    timeInputOperations.deleteTimeInput(savedTimers![index]);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Timer has been deleted'),
                        actions: [
                          Center(
                            child: TextButton(
                              child: Container(
                                height: 30,
                                width: 80,
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                              onPressed: () => Navigator.of(context).pushReplacementNamed('study_lock')
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );

                // return Dismissible(
                //   key: UniqueKey(),
                //
                //   // CUSTOM DISMISSIBLE PARAMETER
                //
                //   child: TimerButton(timeInput: savedTimers![index]),
                //   onDismissed: (direction) {
                //     timeInputOperations.deleteTimeInput(savedTimers![index]);
                //   },
                // );

              },
            ),
          ]);
  }
}
