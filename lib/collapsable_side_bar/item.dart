import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class Item {
  const Item({
    @required this.title,
    @required this.icon,
    @required this.onPressed,
  });

  final String title;
  final IconData icon;
  final Function onPressed;
}
