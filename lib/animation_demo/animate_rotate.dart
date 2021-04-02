import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimateRotation extends StatefulWidget {
  @override
  _AnimateRotationState createState() => _AnimateRotationState();
}

class _AnimateRotationState extends State<AnimateRotation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _curved, _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _animation = Tween<double>(begin: 0, end: 2 * math.pi).animate(_curved)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _animation.value,
              child: child,
            );
          },
          child: LogoWidget(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      height: 150,
      width: 150,
      child: FlutterLogo(),
    );
  }
}
