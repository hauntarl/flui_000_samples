import 'package:flutter/material.dart';

class AnimateOpacity extends StatefulWidget {
  @override
  _AnimateOpacityState createState() => _AnimateOpacityState();
}

class _AnimateOpacityState extends State<AnimateOpacity>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _curved;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.linearToEaseOut,
    )..addStatusListener((status) {
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
          height: 150,
          width: 150,
          child: AnimatedLogo(animation: _curved),
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

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({
    Key? key,
    required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Opacity(
      opacity: animation.value,
      child: FlutterLogo(),
    );
  }
}
