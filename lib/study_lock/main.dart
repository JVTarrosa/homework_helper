import 'package:flutter/material.dart';
import 'package:project_testing/study_lock/time_picker.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      backgroundColor: Colors.black54,
      image: Image.asset('assets/stg_logo.png'),
      loaderColor: Colors.white,
      photoSize: 150.0,
      navigateAfterSeconds: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(30.0),
        // width: 40.0,
        // height: 10.0,
        child: PomodoroButton(),
      ),
    );
  }
}

class PomodoroButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200.0,
        height: 50.0,
        child: ElevatedButton(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.lock_clock,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text('Pomodoro mode',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ]),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => NumPicker()));
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.blue, // background
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0)) // foreground
              ),
        ));
    // ),
  }
}
