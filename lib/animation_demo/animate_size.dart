import 'package:flutter/material.dart';

class AnimateSize extends StatefulWidget {
  @override
  _AnimateSizeState createState() => _AnimateSizeState();
}

class _AnimateSizeState extends State<AnimateSize>
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
      curve: Curves.fastLinearToSlowEaseIn,
    );
    _animation = Tween<double>(begin: 0, end: 150).animate(_curved)
      ..addListener(() => setState(() {}))
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
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          height: _animation.value,
          width: _animation.value,
          child: FlutterLogo(),
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
