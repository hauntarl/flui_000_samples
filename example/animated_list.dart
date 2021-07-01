import 'package:flutter/material.dart';
import 'package:flutter_samples/color_picker.dart';

void main() => runApp(AnimatedListDemo());

class AnimatedListDemo extends StatelessWidget {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final itemColor = <Color>[];

  Widget buildItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Container(
        height: 75,
        width: double.infinity,
        decoration: BoxDecoration(
          color: index != -1 ? itemColor[index] : Colors.blueGrey.shade900,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          index != -1 ? 'Index $index' : 'Index Removed',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
    );
  }

  Widget animatedItem(int index, Animation<double> animation) {
    final Animation<Offset> offset = Tween<Offset>(
      begin: const Offset(1, 0),
      end: const Offset(0, 0),
    ).animate(animation);
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: offset,
        child: SizeTransition(
          sizeFactor: animation,
          child: buildItem(index),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: AnimatedList(
            key: listKey,
            padding: const EdgeInsets.symmetric(vertical: 4),
            physics: BouncingScrollPhysics(),
            initialItemCount: itemColor.length,
            itemBuilder: (_, index, animation) {
              return GestureDetector(
                child: animatedItem(
                  index,
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.fastLinearToSlowEaseIn,
                  ),
                ),
                onTap: () {
                  const duration = Duration(milliseconds: 500);
                  itemColor.removeAt(index);
                  listKey.currentState!.removeItem(
                    index,
                    (_, animation) => animatedItem(
                      -1,
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutQuint,
                      ),
                    ),
                    duration: duration,
                  );
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              itemColor.add(ColorPicker.randomColor());
              listKey.currentState!.insertItem(
                itemColor.length - 1,
                duration: const Duration(seconds: 1),
              );
            },
            backgroundColor: Colors.blueGrey.shade900,
            child: Icon(
              Icons.add_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
