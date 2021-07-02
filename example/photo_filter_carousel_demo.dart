import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_samples/photo_filter_carousel/photo_filter_carousel.dart';

void main() => runApp(PhotoFilterDemo());

// tutorial: https://flutter.dev/docs/cookbook/effects/photo-filter-carousel#add-a-selector-ring-and-dark-gradient
class PhotoFilterDemo extends StatefulWidget {
  @override
  _PhotoFilterState createState() => _PhotoFilterState();
}

class _PhotoFilterState extends State<PhotoFilterDemo> {
  final String _backgroundImagePath = 'assets/filter-image.jpg';
  final String _filterTexturePath = 'assets/filter-texture.jpg';
  final _filters = Colors.primaries.map((c) => c.withOpacity(0.3)).toList();

  late final Uint8List _backgroundImageBytes, _filterTextureBytes;
  late final Future<void> _imageBytesloader;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ));
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

    _imageBytesloader = _loadImageBytes();

    final end = _filters.length - 1;
    final mid = end ~/ 2 + 1;
    final tmp = _filters[end];
    _filters[end] = _filters[mid];
    _filters[mid] = tmp;
  }

  Future<void> _loadImageBytes() async {
    final backgroundImageFuture = _getBytes(_backgroundImagePath);
    final filterTextureFuture = _getBytes(_filterTexturePath);
    _backgroundImageBytes = await backgroundImageFuture;
    _filterTextureBytes = await filterTextureFuture;
  }

  Future<Uint8List> _getBytes(String path) async {
    final bytes = await rootBundle.load(path);
    return bytes.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _imageBytesloader,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return PhotoFilterCarousel(
            backgroundImageBytes: _backgroundImageBytes,
            filterTextureBytes: _filterTextureBytes,
            filters: _filters,
          );
        },
      ),
    );
  }
}
