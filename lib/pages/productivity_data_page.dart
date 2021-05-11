import 'package:flutter/material.dart';
import 'package:project_testing/menus/drawer_menus.dart';

class ProductivityData extends StatefulWidget {
  @override
  _ProductivityDataState createState() => _ProductivityDataState();
}

class _ProductivityDataState extends State<ProductivityData> {
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
                  'Productivity Data',
                  style: TextStyle(
                  color: Colors.white
              ),
              ),
            ),
          ),
          body: Container(
            child: Center(
              child: Text(
                'Change Center widget to edit the body'
              ),
            ),
          )
      ),
    );
  }
}
