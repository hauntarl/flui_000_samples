import 'package:flutter/material.dart';

import './color_picker.dart';
import './sliver_header.dart';

class SliversImpl extends StatelessWidget {
  final Color bgColor;

  SliversImpl({required this.bgColor});

  final _controller = ScrollController();

  Widget get _sliverAppBar {
    return SliverAppBar(
      backgroundColor: bgColor,
      expandedHeight: 150,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Slivers Demo'),
        centerTitle: true,
        background: Image.asset(
          'assets/wallpapersunset.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget get _sliverList {
    final colors = ColorPicker.shuffleColors();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, i) => Container(color: colors[i % ColorPicker.length], height: 150),
        childCount: 6, // comment this to create infinite items
      ),
    );
  }

  Widget get _sliverListFixedExtent {
    final colors = ColorPicker.shuffleColors();
    return SliverFixedExtentList(
      itemExtent: 100,
      delegate: SliverChildBuilderDelegate(
        (_, i) => Container(color: colors[i % ColorPicker.length]),
        childCount: 12, // comment this to create infinite items
      ),
    );
  }

  Widget get _sliverGridFixedCount {
    final colors = ColorPicker.shuffleColors();
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      delegate: SliverChildBuilderDelegate(
        (_, i) => Container(color: colors[i % ColorPicker.length], height: 150),
        childCount: 12, // comment this to create infinite items
      ),
    );
  }

  Widget get _sliverGridMaxExtent {
    final colors = ColorPicker.shuffleColors();
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
      ),
      delegate: SliverChildBuilderDelegate(
        (_, i) => Container(color: colors[i % ColorPicker.length], height: 150),
        childCount: 24, // comment this to create infinite items
      ),
    );
  }

  Widget _makeHeader(String title) {
    final header = Text(
      title,
      style: TextStyle(color: Colors.blueGrey.shade200, fontSize: 20),
    );
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderDelegate(
        maxHeight: 100,
        minHeight: 50,
        child: Container(
          color: bgColor,
          alignment: Alignment.center,
          child: header,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      physics: const BouncingScrollPhysics(),
      slivers: [
        _sliverAppBar,
        _makeHeader('Sliver Grid with Fixed Count'),
        _sliverGridFixedCount,
        _makeHeader('Sliver List'),
        _sliverList,
        _makeHeader('Sliver Grid with Max Extent'),
        _sliverGridMaxExtent,
        _makeHeader('Sliver List with Fixed Extent'),
        _sliverListFixedExtent,
      ],
    );
  }
}
