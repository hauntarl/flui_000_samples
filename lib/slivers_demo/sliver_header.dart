import 'package:flutter/material.dart';

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight, maxHeight;
  final Widget child;

  const SliverHeaderDelegate({
    required this.maxHeight,
    required this.minHeight,
    required this.child,
  });

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant SliverHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
