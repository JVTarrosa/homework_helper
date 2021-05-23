import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_testing/accessories/drawer_menus.dart';
import 'package:project_testing/accessories/theme_settings.dart';
import 'package:provider/provider.dart';
import 'package:project_testing/accessories/snackbar.dart';

class ThemeSelectPage extends StatefulWidget {
  @override
  _ThemeSelectPageState createState() => _ThemeSelectPageState();
}

class _ThemeSelectPageState extends State<ThemeSelectPage> {
  String appBarTitle = 'Theme Select';
  String bodyText = 'Fill in this area please';

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
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          ],
          title: Center(
            child: Text(
              '$appBarTitle',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      'Select a Theme',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Theme.of(context).focusColor, width: 5),
                      ),
                      child: Icon(
                        FontAwesomeIcons.paintRoller,
                        color: Theme.of(context).accentColor,
                        size: 60,
                      ),
                    )
                  ],
                ),
              ),
              Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => themeButton(
                        context,
                        Colors.blueGrey,
                        'Classic',
                        () {
                          notifier.setThemeInt(1);
                        },
                      )),
              Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => themeButton(
                        context,
                        Color.fromARGB(255, 185, 95, 155),
                        'Pink',
                        () {
                          notifier.setThemeInt(2);
                        },
                      )),
              Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => themeButton(
                        context,
                        Color.fromARGB(255, 95, 140, 70),
                        'Green',
                        () {
                          notifier.setThemeInt(3);
                        },
                      )),
              Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => themeButton(
                        context,
                        Color.fromARGB(255, 20, 100, 175),
                        'Cobalt',
                        () {
                          notifier.setThemeInt(4);
                        },
                      )),
              Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => themeButton(
                        context,
                        Color.fromARGB(255, 235, 140, 65),
                        'Orange',
                        () {
                          notifier.setThemeInt(5);
                        },
                      )),
              Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => themeButton(
                        context,
                        Color.fromARGB(255, 10, 140, 130),
                        'Teal',
                        () {
                          notifier.setThemeInt(6);
                        },
                      )),
              Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => themeButton(
                        context,
                        Color.fromARGB(255, 190, 40, 40),
                        'Red',
                        () {
                          notifier.setThemeInt(7);
                        },
                      )),
            ],
          ),
        ),
      ),
    );
  }

  Widget themeButton(BuildContext context, Color color, String themeName,
      void Function() onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: TextButton(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
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
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color,
                  ),
                  height: 30,
                  width: 30,
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Text(
                '$themeName',
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 20),
              )
            ]),
          ),
          onPressed: onPressed),
    );
  }
}
