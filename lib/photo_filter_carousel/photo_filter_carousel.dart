import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart';

import './filter_selector.dart';

class PhotoFilterCarousel extends StatelessWidget {
  final Uint8List backgroundImageBytes, filterTextureBytes;
  final List<Color> filters;

  const PhotoFilterCarousel({
    Key? key,
    required this.backgroundImageBytes,
    required this.filterTextureBytes,
    required this.filters,
  }) : super(key: key);

  static const _insets = EdgeInsets.symmetric(vertical: 24);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned.fill(
          child: Image.memory(
            backgroundImageBytes,
            fit: BoxFit.cover,
          ),
        ),
        FilterSelector(
          textureBytes: filterTextureBytes,
          insets: _insets,
          filters: filters,
        ),
      ],
    );
  }
}
