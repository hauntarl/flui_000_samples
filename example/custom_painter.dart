import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_samples/custom_painter/painter.dart';

void main() => runApp(CustomPainterDemo());

class CustomPainterDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Theme.of(context).canvasColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: CustomPaint(
          painter: Painter(),
          child: Container(
            height: 500,
          ),
        ),
      ),
    );
  }
}
