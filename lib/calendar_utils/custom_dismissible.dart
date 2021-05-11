import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomDismissible<T> extends StatelessWidget {
  final T item;
  final Widget child;
  final DismissDirectionCallback onDismissed;

  const CustomDismissible({
    @required this.item,
    @required this.child,
    @required this.onDismissed,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: ObjectKey(item),
        background: leftSwipe(),
        secondaryBackground: rightSwipe(),
        child: child,
      onDismissed: onDismissed
    );
  }

  // EDIT FUNCTION SWIPE LOOK
  Widget leftSwipe() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10)
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(10),
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }

  // DELETE FUNCTION SWIPE LOOK
  Widget rightSwipe() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(10)
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(10),
        child: Icon(
            Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

}
