import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventForm extends StatelessWidget {
  final BuildContext context;
  final String? title;
  final String? description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final Color generalTextColor;

  const EventForm({
    Key? key,
    required this.context,
    this.title = '',
    this.description = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.generalTextColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          titleBox(),
          SizedBox(height: 8),
          descriptionBox(),
          SizedBox(height: 16),
        ],
      ),
    ),
  );

  Widget titleBox() => TextFormField(

    maxLines: 1,
    inputFormatters: [
      LengthLimitingTextInputFormatter(25)
    ],
    initialValue: title,
    style: TextStyle(
      color: generalTextColor,
      fontSize: 24,
    ),
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'Event Title',
      labelStyle: TextStyle(
        color: generalTextColor,
        fontSize: 30,
        fontWeight: FontWeight.bold
      ),
    ),
    validator: (title) =>
    title != null && title.isEmpty ? 'The title cannot be empty' : null,
    onChanged: onChangedTitle,
  );

  Widget descriptionBox() => TextFormField(
    maxLines: 2,
    inputFormatters: [
      LengthLimitingTextInputFormatter(100)
    ],
    initialValue: description,
    style: TextStyle(color: generalTextColor, fontSize: 18),
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'Event Description',
      labelStyle: TextStyle(
          color: generalTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold
      ),
    ),
    validator: (title) => title != null && title.isEmpty
        ? 'The description cannot be empty'
        : null,
    onChanged: onChangedDescription,
  );


}
