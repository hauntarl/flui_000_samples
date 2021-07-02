import 'dart:math' as math;
import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart';
import 'package:flutter_samples/photo_filter_carousel/filter_item.dart';

@immutable
class FilterSelector extends StatefulWidget {
  final EdgeInsets insets;
  final List<Color> filters;
  final Uint8List textureBytes;

  const FilterSelector({
    Key? key,
    required this.insets,
    required this.filters,
    required this.textureBytes,
  }) : super(key: key);

  @override
  _FilterSelectorState createState() => _FilterSelectorState();
}

class _FilterSelectorState extends State<FilterSelector> {
  static const _filtersPerScreen = 5;
  static const _viewportFractionPerItem = 1 / _filtersPerScreen;

  late final PageController _carouselController, _pageController;

  @override
  void initState() {
    super.initState();

    final initialPage = widget.filters.length ~/ 2;
    _carouselController = PageController(
      viewportFraction: _viewportFractionPerItem,
      initialPage: initialPage,
    );
    _pageController = PageController(initialPage: initialPage);

    _carouselController.addListener(() {
      _pageController.animateTo(
        _carouselController.offset * _filtersPerScreen,
        duration: const Duration(milliseconds: 450),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    });
  }

  @override
  void dispose() {
    _carouselController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final itemSize = constraints.maxWidth * _viewportFractionPerItem;
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _buildFilterBackground(),
            _buildCarousel(itemSize),
            _buildSelectorRing(itemSize),
          ],
        );
      },
    );
  }

  Widget _buildFilterBackground() {
    return SizedBox.expand(
      child: PageView.builder(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.filters.length,
        itemBuilder: (_, index) {
          return ColoredBox(color: _itemColor(index));
        },
      ),
    );
  }

  Widget _buildCarousel(double itemSize) {
    return Container(
      height: itemSize,
      margin: widget.insets,
      child: PageView.builder(
        controller: _carouselController,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.filters.length,
        itemBuilder: (_, index) {
          return Center(
            child: AnimatedBuilder(
              animation: _carouselController,
              builder: (context, child) => _buildFilterItem(
                context,
                child,
                index,
                itemSize,
              ),
            ),
          );
        },
      ),
    );
  }

  Color _itemColor(int index) => widget.filters[index];

  void _onFilterTapped(int index) {
    _carouselController.animateToPage(
      index,
      duration: const Duration(milliseconds: 450),
      curve: Curves.ease,
    );
  }

  Widget _buildFilterItem(
    BuildContext context,
    Widget? child,
    int index,
    double itemSize,
  ) {
    if (!_carouselController.hasClients ||
        !_carouselController.position.hasContentDimensions) {
      return SizedBox();
    }

    final page = _carouselController.page!;
    final selectedIndex = page.roundToDouble();
    final scrollAmount = page - selectedIndex;
    final maxScrollDistance = _filtersPerScreen / 2;
    final distanceFromSelected = (selectedIndex - index + scrollAmount).abs();
    final percentFromCenter = 1 - distanceFromSelected / maxScrollDistance;

    final opacity = 0.25 + (percentFromCenter * 0.75);
    final scale = 0.5 + (percentFromCenter * 0.5);
    final margin = widget.insets.bottom;
    final dy = margin - margin * math.sin(percentFromCenter * math.pi / 2);

    return Transform.translate(
      offset: Offset(0, dy),
      child: Transform.scale(
        scale: scale,
        child: Opacity(
          opacity: opacity,
          child: FilterItem(
            imageBytes: widget.textureBytes,
            color: _itemColor(index),
            onSelected: () => _onFilterTapped(index),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectorRing(double itemSize) {
    return IgnorePointer(
      child: Padding(
        padding: widget.insets,
        child: SizedBox(
          width: itemSize,
          height: itemSize,
          child: const DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.fromBorderSide(BorderSide(
                width: 6,
                color: Colors.white,
              )),
            ),
          ),
        ),
      ),
    );
  }
}
