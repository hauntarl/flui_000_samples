import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const bgColor = Color(0xFF652A78);
const red = Color(0xFFDE3C10);
const purple = Color(0xFF8132AD);
const cyan = Color(0xFF99D5E5);
const orange = Color(0xFFE97A4D);

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

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height, w = size.width;
    final paint = Paint();

    final bgPath = Path()..addRect(Rect.fromLTWH(0, 0, w, h));
    paint.color = bgColor;
    canvas.drawPath(bgPath, paint);

    final redPath = Path()
      ..moveTo(0, size.height * .9)
      ..quadraticBezierTo(w * .35, h * .2, w, 0)
      ..lineTo(w, h * .5)
      ..quadraticBezierTo(w * .5, h * .7, w * .25, h)
      ..close();
    paint.color = red;
    canvas.drawPath(redPath, paint);

    final purplePath = Path()
      ..lineTo(0, h * .5)
      ..quadraticBezierTo(w * .3, h * .25, w * .5, 0)
      ..close();
    paint.color = purple;
    canvas.drawPath(purplePath, paint);

    final orangePath = Path()
      ..moveTo(0, h * .75)
      ..quadraticBezierTo(w * .3, h * .85, w * .5, h)
      ..lineTo(0, h)
      ..close();
    paint.color = orange;
    canvas.drawPath(orangePath, paint);

    final cyanPath = Path()
      ..lineTo(0, w * .25)
      ..lineTo(w * .25, 0)
      ..close();
    paint.color = cyan;
    canvas.drawPath(cyanPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
