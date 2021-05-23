import 'package:flutter/material.dart';
import 'package:project_testing/accessories/drawer_menus.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

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
                onPressed:  () => Scaffold.of(context).openDrawer(),
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
                'About',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
          ),
          body:  Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/stg_logo.png',
                  ),
                  SizedBox(height: 30,),
                  Text(
                      'Homework Helper is a creation by STG\n'
                          '(AKA Tres Leches) as a finals output\n'
                          'for software development classes under\n'
                          'Sir Richard Coo and Ma\'am Ariessa Ko',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      )
                  ),
                  SizedBox(height: 20,),
                  Text(
                      'MEMBERS:\n'
                          'John Victor S. Tarrosa\n'
                          'Kian Aira B. Salazar\n'
                          'Paul Vincent C. Garibay',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      )
                  ),

                ],
              ),
            ),
          )
      ),
    );


  }
}
