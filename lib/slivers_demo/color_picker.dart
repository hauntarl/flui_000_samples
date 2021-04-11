import 'dart:math' show Random;

import 'package:flutter/material.dart' show Color, Colors;

class ColorPicker {
  ColorPicker._();

  static final random = Random(DateTime.now().millisecondsSinceEpoch);
  static final colors = Colors.primaries.map((c) => c.shade300).toList();
  static final length = colors.length;

  static Color randomColor() => colors[random.nextInt(length)];

  static List<Color> shuffleColors() {
    final copy = List<Color>.from(colors);
    copy.shuffle(ColorPicker.random);
    return copy;
  }
}
