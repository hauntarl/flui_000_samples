import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_samples/custom_painter/painter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() => runApp(PerspectiveDemo());

class PerspectiveDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Perspective(),
    );
  }
}

class Perspective extends StatefulWidget {
  @override
  _PerspectiveState createState() => _PerspectiveState();
}

class _PerspectiveState extends State<Perspective>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation parent;
  late Animation<Offset> animation;
  var offset = Offset.zero;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() => setState(() => offset = animation.value));

    parent = CurvedAnimation(
      parent: controller,
      curve: Curves.fastLinearToSlowEaseIn,
    );

    animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(parent);
  }

  void startAnimation(Offset offset) {
    animation = Tween<Offset>(
      begin: offset,
      end: Offset.zero,
    ).animate(parent);
    controller.reset();
    controller.forward();
  }

  void flingAnimation(Offset offset, Velocity velocity) {
    final end = Offset(
      offset.dx + 0.1 * velocity.pixelsPerSecond.dx,
      offset.dy + 0.1 * velocity.pixelsPerSecond.dy,
    );
    animation = Tween<Offset>(
      begin: offset,
      end: end,
    ).animate(parent);
    controller.reset();
    controller.fling(
      velocity: 0.05,
      springDescription: SpringDescription.withDampingRatio(
        mass: 10,
        stiffness: 0.1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(0.01 * offset.dy)
        ..rotateY(-0.01 * offset.dx),
      // ..rotateZ(-0.005 * (offset.dx + offset.dy)),
      alignment: FractionalOffset.center,
      child: GestureDetector(
        onTapDown: (_) => controller.stop(),
        onPanStart: (_) => controller.stop(),
        onDoubleTap: () => startAnimation(offset),
        onPanUpdate: (details) => setState(() => offset += details.delta),
        onPanEnd: (details) => flingAnimation(offset, details.velocity),
        child: page,
      ),
    );
  }

  Widget get page {
    return Scaffold(
      body: CustomPaint(
        painter: Painter(),
        child: Container(height: 700),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
