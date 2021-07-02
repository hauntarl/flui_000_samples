import 'dart:typed_data';

import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  final Uint8List imageBytes;
  final Color color;
  final VoidCallback onSelected;

  const FilterItem({
    Key? key,
    required this.imageBytes,
    required this.color,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipOval(
            child: Image.memory(
              imageBytes,
              color: color.withOpacity(0.5),
              colorBlendMode: BlendMode.hardLight,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
