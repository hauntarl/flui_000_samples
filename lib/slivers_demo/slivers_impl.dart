import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './color_picker.dart';
import './sliver_header.dart';

double Function(double) _offsetAccumulator() {
  var offset = 0.0;
  return (double newVal) {
    offset += newVal;
    return offset;
  };
}

class SliversImpl extends StatelessWidget {
  final Color bgColor;

  SliversImpl({required this.bgColor});

  Widget _sliverAppBar(double maxHeight) {
    return SliverAppBar(
      backgroundColor: bgColor,
      expandedHeight: maxHeight,
      pinned: true,
      // systemOverlayStyle: SystemUiOverlayStyle.dark,
      brightness: Brightness.dark,
      primary: true,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Slivers Demo',
          style: TextStyle(letterSpacing: 1, fontSize: 20),
        ),
        centerTitle: true,
        background: Image.asset(
          'assets/wallpapersunset.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _sliverList(double itemExtent, int childCount) {
    final colors = ColorPicker.shuffleColors();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, i) => Container(
          color: colors[i % ColorPicker.length],
          height: itemExtent,
        ),
        childCount: childCount, // comment this to create infinite items
      ),
    );
  }

  Widget _sliverListFixedExtent(double itemExtent, int childCount) {
    final colors = ColorPicker.shuffleColors();
    return SliverFixedExtentList(
      itemExtent: itemExtent,
      delegate: SliverChildBuilderDelegate(
        (_, i) => Container(color: colors[i % ColorPicker.length]),
        childCount: childCount, // comment this to create infinite items
      ),
    );
  }

  Widget _sliverGridFixedCount(
    double itemExtent,
    int axisCount,
    int childCount,
  ) {
    final colors = ColorPicker.shuffleColors();
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: axisCount,
      ),
      delegate: SliverChildBuilderDelegate(
        (_, i) => Container(
          color: colors[i % ColorPicker.length],
          height: itemExtent,
        ),
        childCount: childCount, // comment this to create infinite items
      ),
    );
  }

  Widget _sliverGridMaxExtent(double axisExtent, double itemExtent) {
    final colors = ColorPicker.shuffleColors();
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: axisExtent,
      ),
      delegate: SliverChildBuilderDelegate(
        (_, i) => Container(
          color: colors[i % ColorPicker.length],
          height: itemExtent,
        ),
        // childCount: 24, // comment this to create infinite items
      ),
    );
  }

  final ScrollController _controller = ScrollController();

  Widget _makeHeader(String title, double offset) {
    final header = Text(
      title,
      style: TextStyle(
        color: Colors.blueGrey.shade200,
        fontSize: 20,
        letterSpacing: 1,
      ),
    );
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderDelegate(
        maxHeight: 76,
        minHeight: 51,
        onTap: () => _controller.animateTo(
          offset,
          duration: Duration(seconds: 1),
          curve: Curves.fastLinearToSlowEaseIn,
        ),
        child: Container(
          color: bgColor,
          alignment: Alignment.center,
          child: header,
        ),
      ),
    );
  }

  Widget get _floatingActionButton {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        onPressed: () => _controller.animateTo(
          0,
          duration: Duration(seconds: 1),
          curve: Curves.fastLinearToSlowEaseIn,
        ),
        backgroundColor: bgColor,
        child: Icon(
          Icons.keyboard_arrow_up_rounded,
          size: 36,
          color: Colors.blueGrey.shade200,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _pixels = _offsetAccumulator();
    // _sliverAppBar
    final expandedHeight = 200.0;
    // _sliverList
    final listItemExtent = 150.0;
    final listChildCount = 6;
    // _sliverListFixedExtent
    final listExtentItemExtent = 100.0;
    final listExtentChildCount = 12;
    // _sliverGridFixedCount
    final gridCountItemExtent = 150.0;
    final gridCountAxisCount = 3;
    final gridCountChildCount = 12;
    // _sliverGridMaxExtent
    final gridExtentAxisExtent = 100.0;
    final gridExtentItemExtent = 150.0;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CustomScrollView(
          controller: _controller,
          physics: const BouncingScrollPhysics(),
          slivers: [
            _sliverAppBar(expandedHeight),
            _makeHeader(
              'Sliver List',
              _pixels(expandedHeight - kToolbarHeight), // offset from appbar
            ),
            _sliverList(listItemExtent, listChildCount),
            _makeHeader(
              'Sliver Grid with Fixed Count',
              _pixels(listChildCount * listItemExtent + 25), // + header
            ),
            _sliverGridFixedCount(
              gridCountItemExtent,
              gridCountAxisCount,
              gridCountChildCount,
            ),
            _makeHeader(
              'Sliver List with Fixed Extent',
              _pixels(gridCountChildCount /
                      gridCountAxisCount *
                      gridCountItemExtent +
                  25),
            ),
            _sliverListFixedExtent(listExtentItemExtent, listExtentChildCount),
            _makeHeader(
              'Sliver Grid with Max Extent',
              _pixels(listExtentChildCount * listExtentItemExtent + 25),
            ),
            _sliverGridMaxExtent(gridExtentAxisExtent, gridExtentItemExtent),
          ],
        ),
        _floatingActionButton,
      ],
    );
  }
}
