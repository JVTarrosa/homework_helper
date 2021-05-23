import 'package:flutter/material.dart';
import 'package:project_testing/calendar_utils/event_object.dart';
import 'package:project_testing/database/event_operations.dart';
import 'package:project_testing/accessories/drawer_menus.dart';
import 'package:project_testing/productivity_utils/total_chart.dart';
import 'package:project_testing/productivity_utils/page_chart.dart';
import 'package:project_testing/productivity_utils/pdf_data_object.dart';
import 'package:pdf/pdf.dart';
import 'package:project_testing/productivity_utils/pdfFile.dart';

class ProductivityData extends StatefulWidget {
  @override
  _ProductivityDataState createState() => _ProductivityDataState();
}

class _ProductivityDataState extends State<ProductivityData> {
  EventOperations eventOperations = EventOperations();

  Future<List<List<dynamic>>> _getData() async {
    List<Event> week1 = await eventOperations.getEventsByWeek(1);
    List<Event> week2 = await eventOperations.getEventsByWeek(2);
    List<Event> week3 = await eventOperations.getEventsByWeek(3);
    List<Event> week4 = await eventOperations.getEventsByWeek(4);
    List<Event> eventsThisMonth = await eventOperations.getEventsThisMonth();
    int week1Done = 0;
    week1.forEach(
            (event) => week1Done += event.status == EventStatus.complete ? 1 : 0);
    int week2Done = 0;
    week2.forEach(
            (event) => week2Done += event.status == EventStatus.complete ? 1 : 0);
    int week3Done = 0;
    week3.forEach(
            (event) => week3Done += event.status == EventStatus.complete ? 1 : 0);
    int week4Done = 0;
    week4.forEach(
            (event) => week4Done += event.status == EventStatus.complete ? 1 : 0);
    int completedThisMonth = 0;
    eventsThisMonth.forEach((event) {
      completedThisMonth += event.status == EventStatus.complete ? 1 : 0;
    });

    return [
      ['Week 1', week1.length, week1Done],
      ['Week 2', week2.length, week2Done],
      ['Week 3', week3.length, week3Done],
      ['Week 4', week4.length, week4Done],
      ['TOTAL', eventsThisMonth.length, completedThisMonth]
    ];
  }

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
              'Productivity Data',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  FutureBuilder(
                    future: _getData(),
                    builder: (context, AsyncSnapshot<List<List>> snapshot) {
                      return snapshot.connectionState == ConnectionState.done
                          ? PageChart(barValues: snapshot.data)
                          : CircularProgressIndicator();
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            color: Theme.of(context).accentColor,
                          ),
                          SizedBox(width: 10),
                          Column(
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              Text(
                                'Work',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            color: Theme.of(context).focusColor,
                          ),
                          SizedBox(width: 10),
                          Column(
                            children: [
                              Text(
                                'Work',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              Text(
                                'Completed',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  FutureBuilder(
                    future: _getData(),
                    builder: (context, AsyncSnapshot<List<List>> snapshot) {
                      return snapshot.connectionState == ConnectionState.done
                          ? TotalChart(barValues: snapshot.data)
                          : CircularProgressIndicator();
                    },
                  ),

                  //PDF button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor, // background
                      onPrimary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    child: Text(
                      "Get PDF",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20.0),
                    ),
                    onPressed: () async {
                      final pdfData = PdfData(data: await _getData());
                      final pdfFile = await PdfFile.generate(pdfData);

                      PdfFile.openFile(pdfFile);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
