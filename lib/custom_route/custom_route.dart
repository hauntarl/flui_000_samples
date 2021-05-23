import 'package:flutter/material.dart';

class CustomRoute extends PageRouteBuilder {
  final Widget parent, child;

  CustomRoute({
    required this.parent,
    required this.child,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curve = CurveTween(curve: Curves.easeOut);
            final offsetChild = Tween(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).chain(curve);
            final offsetParent = Tween(
              begin: Offset.zero,
              end: const Offset(-0.4, 0),
            ).chain(curve);
            return Stack(
              children: [
                SlideTransition(
                  position: animation.drive(offsetParent),
                  child: parent,
                ),
                SlideTransition(
                  position: animation.drive(offsetChild),
                  child: child,
                ),
              ],
            );
          },
        );
}
