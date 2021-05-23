import 'package:flutter/material.dart';
import 'package:flutter_samples/custom_painter/painter.dart';
import 'package:flutter_samples/custom_route/custom_route.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

// https://flutter.dev/docs/cookbook/animation/page-route-animation
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).push(CustomRoute(
            parent: this,
            child: NextPage(),
          )),
          child: Text('Go!'),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: Painter(),
        child: Container(
          height: 700,
        ),
      ),
    );
  }
}
