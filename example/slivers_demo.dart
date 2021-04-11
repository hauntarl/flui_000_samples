import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_samples/slivers_demo/slivers_impl.dart';

void main() => runApp(SliversDemo());

class SliversDemo extends StatelessWidget {
  static const _bgColor = Color(0xff0D1117);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: _bgColor,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: _bgColor,
        body: SliversImpl(bgColor: _bgColor),
      ),
    );
  }
}
