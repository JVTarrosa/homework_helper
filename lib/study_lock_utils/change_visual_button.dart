import 'package:flutter/material.dart';
import 'package:project_testing/accessories/lock_visual_settings.dart';
import 'package:provider/provider.dart';

class ChangeVisualButton extends StatelessWidget {
  const ChangeVisualButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200.0,
        height: 50.0,
        child: ElevatedButton(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Change Lock Visual',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ]),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text('Select a Visual'),
                      actions: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer<LockVisualNotifier>(
                              builder: (context, notifier, child) =>
                                  visualButton(
                                context,
                                notifier,
                                1,
                                'assets/study_lock/fishingcat_icon.png',
                                'Fishing Cat',
                                () {
                                  notifier.setLockInt(1);
                                },
                              ),
                            ),
                            Consumer<LockVisualNotifier>(
                              builder: (context, notifier, child) =>
                                  visualButton(
                                context,
                                notifier,
                                2,
                                'assets/study_lock/sharkhunt_icon.png',
                                'Hunting Shark',
                                () {
                                  notifier.setLockInt(2);
                                },
                              ),
                            ),
                            Consumer<LockVisualNotifier>(
                              builder: (context, notifier, child) =>
                                  visualButton(
                                context,
                                notifier,
                                3,
                                'assets/study_lock/cityriver_icon.png',
                                'Sunset City',
                                () {
                                  notifier.setLockInt(3);
                                },
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Theme.of(context).accentColor,
                                      width: 1,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Done',
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ));
          },
          style: ElevatedButton.styleFrom(
              primary: Theme.of(context).accentColor, // background
              onPrimary: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0)) // foreground
              ),
        ));
  }
}

Widget visualButton(BuildContext context, LockVisualNotifier notifier, int id,
    String asset, String visualName, void Function() onPressed) {
  bool isCurrentVisual = notifier.lockInt == id;

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    child: TextButton(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isCurrentVisual
                    ? Theme.of(context).accentColor
                    : Colors.grey,
                width: 3,
              ),
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black45,
                    blurRadius: 5,
                    spreadRadius: 3,
                    offset: Offset.fromDirection(20))
              ]),
          child: Row(children: [
            Padding(
                padding: const EdgeInsets.all(8.0), child: Image.asset(asset)),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                '$visualName',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            )
          ]),
        ),
        onPressed: onPressed),
  );
}
