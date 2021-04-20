import 'package:flutter/material.dart';

void main() => runApp(ImplicitAnimations());

class ImplicitAnimations extends StatelessWidget {
  Widget get container {
    return Container(
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xffBFE5F5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              container,
              AnimationDemo(),
              container,
            ],
          ),
        ),
      ),
    );
  }
}

class AnimationDemo extends StatefulWidget {
  @override
  _AnimationDemoState createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo> {
  bool first = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => first = !first),
      child: AnimatedDefaultTextStyle(
        duration: Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn,
        style: first
            ? Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.white)
            : Theme.of(context).textTheme.headline2!,
        child: AnimatedCrossFade(
          duration: const Duration(seconds: 1),
          firstCurve: Curves.easeIn,
          secondCurve: Curves.easeOut,
          sizeCurve: Curves.fastOutSlowIn,
          crossFadeState:
              first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: Container(
            height: 250,
            width: 250,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff0274C4),
            ),
            alignment: Alignment.center,
            child: Text('Hello'),
          ),
          secondChild: Container(
            height: 150,
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Color(0xff12B8FE)),
            alignment: Alignment.center,
            child: Text('Goodbye'),
          ),
          layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Positioned(
                  key: bottomChildKey,
                  top: 0,
                  child: bottomChild,
                ),
                Positioned(
                  key: topChildKey,
                  child: topChild,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
