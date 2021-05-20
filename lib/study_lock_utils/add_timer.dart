import 'package:flutter/material.dart';
import 'package:project_testing/study_lock_utils/time_input_object.dart';
import 'study_timer.dart';
import 'time_selectors.dart';
import 'package:project_testing/database/time_input_operations.dart';

class AddTimeInput extends StatefulWidget {
  final TimeInput input;

  AddTimeInput({required this.input});

  @override
  _AddTimeInputState createState() => _AddTimeInputState(input: input);
}

class _AddTimeInputState extends State<AddTimeInput> {
  final TimeInput input;
  TimeInputOperations timeInputOperations = TimeInputOperations();
  final _nameController = TextEditingController();

  _AddTimeInputState({required this.input});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Timer"),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              children: [
                // TIME SELECTORS
                Text(
                  'Enter A Timer Name',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(
                  height: 100.0,
                ),

                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'TIMER NAME'),
                ),

                SizedBox(
                  height: 100.0,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).accentColor, // background
                        onPrimary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ), // foreground
                      ),
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20.0),
                      ),
                      onPressed: () {
                        if (_nameController.text == '') {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Timer Name Cannot Be Empty'),
                              actions: [
                                Center(
                                  child: TextButton(
                                    child: Container(
                                      height: 30,
                                      width: 80,
                                      child: Text(
                                        'OK',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor),
                                      ),
                                    ),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          input.name = _nameController.text;
                          timeInputOperations.createTimeInput(input);
                          Navigator.of(context)
                              .pushReplacementNamed('study_lock');
                        }
                      },
                    ),

                    // CANCEL BUTTON
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).accentColor, // background
                        onPrimary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                      child: Text(
                        "CANCEL",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20.0),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed('study_lock');
                      },
                    )
                  ],
                ),
                // SAVE BUTTON
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
