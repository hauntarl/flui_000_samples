import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimateAll extends StatefulWidget {
  final double maxWidth;

  AnimateAll({required this.maxWidth});

  @override
  _AnimateAllState createState() => _AnimateAllState();
}

class _AnimateAllState extends State<AnimateAll>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _curved;
  late Tween<double> _translate;
  late double width;

  @override
  void initState() {
    super.initState();
    width = widget.maxWidth;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _curved = CurvedAnimation(parent: _controller, curve: Curves.easeOutQuint)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() => _translate = Tween<double>(begin: width / 2, end: 0));
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          setState(() => _translate = Tween<double>(begin: -width / 2, end: 0));
          _controller.forward();
        }
      });
    _translate = Tween<double>(begin: -width / 2, end: 0);
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimateAll oldWidget) {
    super.didUpdateWidget(oldWidget);
    // when we switch from portrait to landscape or vice-versa,, the maxWidth
    // property gets updated, we also need update width property of State
    width = widget.maxWidth;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: width,
      child: Center(
        child: AnimatedLogo(
          animation: _curved,
          translateTween: _translate,
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
  static final _sizeTween = Tween<double>(begin: 0, end: 150);
  static final _opacityTween = Tween<double>(begin: 0, end: 1);
  static final _rotateTween = Tween<double>(begin: 0, end: 2 * math.pi);

  final Tween<double> translateTween;

  AnimatedLogo({
    Key? key,
    required Animation<double> animation,
    required this.translateTween,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    final curSize = _sizeTween.evaluate(animation);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      height: curSize,
      width: curSize,
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Transform.translate(
          offset: Offset(translateTween.evaluate(animation), 0),
          child: Transform.rotate(
            angle: _rotateTween.evaluate(animation),
            child: FlutterLogo(),
          ),
        ),
      ),
    );
  }
}
