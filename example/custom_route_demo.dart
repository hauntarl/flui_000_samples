import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_samples/custom_route/custom_route.dart';
import 'package:flutter_samples/custom_route/layout_demo.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

// https://flutter.dev/docs/cookbook/animation/page-route-animation
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).push(CustomRoute(
            parent: this,
            child: LayoutDemo(),
          )),
          child: Text('Go!'),
        ),
      ),
    );
  }
}
