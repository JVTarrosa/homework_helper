import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_testing/accessories/drawer_menus.dart';

class PremiumStatusPage extends StatelessWidget {
  const PremiumStatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: NavigatorMenu(),
          endDrawer: SettingsMenu(),
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  Icons.reorder,
                  size: 35,
                  color: Colors.white,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    Icons.settings,
                    size: 35,
                    color: Colors.white,
                  ),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ),
            ],
            title: Center(
              child: Text(
                'Premium Status',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          body: Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border:
                          Border.all(color: Colors.orangeAccent, width: 10)),
                  child: Icon(
                    Icons.emoji_events_rounded,
                    color: Colors.orangeAccent,
                    size: 100,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 200,
                    child: Center(
                      child: Text('Premium Version\nIs Active!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                    'All premium features are active\nby default for this test version.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                SizedBox(
                  height: 50,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('home');
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
                        'Return to Home',
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
