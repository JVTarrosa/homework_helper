import 'package:flutter/material.dart';
import 'package:project_testing/study_lock_utils/time_input_object.dart';
import 'add_timer.dart';

class CreateTimerButton extends StatelessWidget {
  final TimeInput timeInput;

  const CreateTimerButton({Key? key, required this.timeInput})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 50.0,
      child: ElevatedButton(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.add,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text('Save Timer',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ]),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => AddTimeInput(input: timeInput),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).accentColor, // background
            onPrimary: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0)) // foreground
            ),
      ),
    );
  }
}

// class CreateTimerButton extends StatelessWidget {
//   const CreateTimerButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 200.0,
//       height: 50.0,
//       child: ElevatedButton(
//         child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.add,
//                 color: Colors.white,
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Text('Create New Timer',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white)),
//             ]),
//         onPressed: () {
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(
//               builder: (context) => AddTimeInput(),
//             ),
//           );
//           // Navigator.push(
//           //     context, MaterialPageRoute(builder: (context) => NumPicker()));
//         },
//         style: ElevatedButton.styleFrom(
//             primary: Theme.of(context).accentColor, // background
//             onPrimary: Theme.of(context).primaryColor,
//             shape: RoundedRectangleBorder(
//                 borderRadius:
//                 BorderRadius.circular(100.0)) // foreground
//         ),
//       ),
//     );
//   }
// }
