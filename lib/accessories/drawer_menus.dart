import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_settings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class SettingsMenu extends StatefulWidget {
  @override
  _SettingsMenuState createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children:  <Widget>[
              Container(
                height: 100,
                child: Center(
                  child: Text(
                    'SETTINGS',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                ),
              ),
              buttonDivider(context),
              Consumer<ThemeNotifier>(
                builder: (context, notifier, child) => TextButton(
                    onPressed: () {
                      notifier.toggleTheme();
                    },
                    child: Container(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: notifier.isDarkTheme ? 25 : 20,
                          ),
                          Container(
                            child: notifier.isDarkTheme ? FaIcon(
                                FontAwesomeIcons.solidMoon,
                                size: 40,
                                color: Theme.of(context).accentColor
                            ) :
                            Icon(
                              Icons.wb_sunny,
                              size: 45,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                      child: Text(
                                        'Toggle',
                                        style: TextStyle(
                                            color: Theme.of(context).accentColor,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20
                                        ),
                                      )
                                  ),
                                  Center(
                                      child: Text(
                                        'Light/Dark',
                                        style: TextStyle(
                                            color: Theme.of(context).accentColor,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20
                                        ),
                                      )
                                  ),
                                ]
                            ),
                          )
                        ],
                      ),
                    ),
                )
              ),
              buttonDivider(context),
              TextButton(
                  onPressed: () {
                      navigateToPage(context, 'premium_status');
                  },
                  child: drawerButton(Icons.emoji_events_rounded, 'Premium', 'Subscription', Theme.of(context).accentColor)
              ),
              buttonDivider(context),
              TextButton(
                  onPressed: () {
                    navigateToPage(context, 'theme_change');
                  },
                  child: drawerButton(Icons.palette_rounded, 'App Theme', 'Settings', Theme.of(context).accentColor)
              ),
              buttonDivider(context),
              TextButton(
                  onPressed: () {
                    navigateToPage(context, 'about_page');
                  },
                  child: drawerButton(Icons.info_rounded, 'About', 'The App', Theme.of(context).accentColor)
              ),
            ]),
      ),
    );
  }
}

class NavigatorMenu extends StatefulWidget {
  @override
  _NavigatorMenuState createState() => _NavigatorMenuState();
}

class _NavigatorMenuState extends State<NavigatorMenu> {
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children:  <Widget>[
              Container(
                height: 100,
                child: Center(
                  child: Text(
                    'MENU',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 40,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                ),
              ),
              buttonDivider(context),
              TextButton(
                onPressed: () {
                  navigateToPage(context, 'home');
                },
                  child: drawerButton(Icons.calendar_today_rounded, 'Schoolwork', 'Calendar', Theme.of(context).accentColor),
              ),
              buttonDivider(context),
              TextButton(
                  onPressed: () {
                    navigateToPage(context, 'work_status');
                  },
                  child: drawerButton(Icons.hourglass_bottom, 'Work', 'Status', Theme.of(context).accentColor)
              ),
              buttonDivider(context),
              TextButton(
                  onPressed: () {
                    navigateToPage(context, 'study_lock');
                  },
                  child: drawerButton(Icons.lock_clock, 'Study', 'Lock', Theme.of(context).accentColor)
              ),
              buttonDivider(context),
              TextButton(
                  onPressed: () {
                    navigateToPage(context, 'productivity_data');
                  },
                  child: drawerButton(Icons.bar_chart_sharp, 'Productivity', 'Data', Theme.of(context).accentColor)
              ),
            ]),
      ),
    );
  }
}

void navigateToPage(BuildContext context, String targetPage) {
  // Navigator.pop(context);
  Navigator.of(context).pushReplacementNamed(targetPage);
}

// widget made to create the small gray lines between the buttons
Widget buttonDivider(BuildContext context) {
  return Center(
    child: Container(
      color:  Theme.of(context).focusColor,
      height: 1,
      width: 255,
    ),
  );
}

// widget created for uniform formatting of the drawer buttons
Widget drawerButton(IconData icon, String topText, String bottomText, Color itColor) {
  return Container(
    height: 80,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
        ),
        Icon(
          icon,
          color: itColor,
          size: 50,
        ),
        Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                      '$topText',
                      style: TextStyle(
                          color: itColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 20
                      ),
                    )
                ),
                Center(
                    child: Text(
                      '$bottomText',
                      style: TextStyle(
                          color: itColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 20
                      ),
                    )
                ),
              ]
          ),
        )
      ],
    ),
  );
}