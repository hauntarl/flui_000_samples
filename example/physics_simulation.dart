import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PhysicsSimulation(),
  ));
}

// https://flutter.dev/docs/cookbook/animation/physics-simulation
class PhysicsSimulation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraggableCard(
        size: MediaQuery.of(context).size,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: FlutterLogo(size: 128),
        ),
      ),
    );
  }
}

class DraggableCard extends StatefulWidget {
  final Size size;
  final Widget child;

  const DraggableCard({required this.size, required this.child});

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Alignment> animation;
  var alignment = Alignment.center;

  void runAnimation(Offset pixelPerSecond) {
    animation = Tween(
      begin: alignment,
      end: Alignment.center,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    ));

    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller.
    final unitsPerSecondX = pixelPerSecond.dx / widget.size.width;
    final unitsPerSecondY = pixelPerSecond.dy / widget.size.height;
    final unitVelocity = Offset(unitsPerSecondX, unitsPerSecondY).distance;

    const spring = SpringDescription(mass: 30, stiffness: 1, damping: 1);
    controller.animateWith(SpringSimulation(spring, 0, 1, -unitVelocity));
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this)
      ..addListener(() => setState(() => alignment = animation.value));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) => controller.stop(),
      onPanUpdate: (details) {
        alignment += Alignment(
          1.5 * details.delta.dx / widget.size.width,
          1.5 * details.delta.dy / widget.size.height,
        );
        setState(() {});
      },
      onPanEnd: (details) => runAnimation(details.velocity.pixelsPerSecond),
      child: Align(
        alignment: alignment,
        child: Card(
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
