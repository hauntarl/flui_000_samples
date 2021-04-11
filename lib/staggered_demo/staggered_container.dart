import 'package:flutter/material.dart';

class StaggeredContainer extends StatefulWidget {
  final double size;
  final Color beginColor, endColor;

  const StaggeredContainer({
    required this.size,
    required this.beginColor,
    required this.endColor,
  });

  @override
  _StaggeredContainerState createState() => _StaggeredContainerState();
}

class _StaggeredContainerState extends State<StaggeredContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant StaggeredContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _StaggeredContainer(
      controller: _controller,
      size: widget.size,
      beginColor: widget.beginColor,
      endColor: widget.endColor,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _StaggeredContainer extends StatelessWidget {
  final double size;
  final Color beginColor, endColor;
  final AnimationController controller;
  final Animation<double> opacity, width, height, margin;
  final Animation<BorderRadius> radius;
  final Animation<Color?> color;

  _StaggeredContainer({
    required this.controller,
    required this.size,
    required this.beginColor,
    required this.endColor,
  })   : opacity = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.1, 0.25, curve: Curves.ease),
        )),
        width = Tween<double>(
          begin: size / 4,
          end: size,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.25, 0.4, curve: Curves.ease),
        )),
        height = Tween<double>(
          begin: size / 4,
          end: size,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.4, 0.55, curve: Curves.ease),
        )),
        margin = Tween<double>(
          begin: 0,
          end: size,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.4, 0.55, curve: Curves.ease),
        )),
        radius = BorderRadiusTween(
          begin: BorderRadius.circular(4),
          end: BorderRadius.circular(size),
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.55, 0.7, curve: Curves.ease),
        )),
        color = ColorTween(
          begin: beginColor,
          end: endColor,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.7, 0.85, curve: Curves.ease),
        ));

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Opacity(
        opacity: opacity.value,
        child: Container(
          margin: EdgeInsets.only(bottom: margin.value),
          height: height.value,
          width: width.value,
          decoration: BoxDecoration(
            border: Border.all(
              color: endColor,
              style: BorderStyle.solid,
              width: 2,
            ),
            borderRadius: radius.value,
            color: color.value,
          ),
        ),
      ),
    );
  }
}
