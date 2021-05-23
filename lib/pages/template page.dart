import 'package:flutter/material.dart';
import 'package:project_testing/accessories/drawer_menus.dart';

class TemplatePage extends StatefulWidget {
  @override
  _TemplatePageState createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  String appBarTitle = 'Template Page';
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
                '$appBarTitle',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
          ),
          body: Image.network(
              'https://drive.google.com/uc?export=view&id=1QHocFamzJtBeCOQdcVzXc5mq2M1GBncs',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          )
      ),
    );
  }
}
