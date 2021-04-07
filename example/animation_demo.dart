import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_samples/animation_demo/animate_all.dart';
import 'package:flutter_samples/animation_demo/animate_rotate.dart';
import 'package:flutter_samples/animation_demo/animate_size.dart';
import 'package:flutter_samples/animation_demo/animate_opacity.dart';

void main() => runApp(AnimationDemo());

/// tutorial: https://flutter.dev/docs/development/ui/animations/tutorial
class AnimationDemo extends StatelessWidget {
  static const bgColor = Color(0xff0D1117);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: bgColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: bgColor,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: bgColor,
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            AnimateSize(),
            AnimateOpacity(),
            AnimateRotation(),
            LayoutBuilder(builder: (context, constraint) {
              return AnimateAll(maxWidth: constraint.maxWidth);
            }),
          ],
        ),
      ),
    );
  }
}
