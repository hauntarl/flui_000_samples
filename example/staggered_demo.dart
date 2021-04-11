import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_samples/staggered_demo/staggered_container.dart';

void main() => runApp(StaggeredDemo());

class StaggeredDemo extends StatelessWidget {
  static const _bgColor = Color(0xff0D1117);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: _bgColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: _bgColor,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: _bgColor,
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
            alignment: Alignment.center,
            child: OverflowBox(
              alignment: Alignment.bottomCenter,
              child: LayoutBuilder(
                builder: (_, contraints) => StaggeredContainer(
                  size: contraints.maxHeight / 2,
                  beginColor: _bgColor,
                  endColor: Colors.blueGrey.shade600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
