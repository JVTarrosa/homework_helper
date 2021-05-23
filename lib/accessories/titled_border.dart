import 'package:flutter/material.dart';

Widget titledBorder(BuildContext context, String borderTitle) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$borderTitle',
        style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold),
      ),
      Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(color: Theme.of(context).accentColor),
            ),
          )
        ],
      )
    ],
  );
}