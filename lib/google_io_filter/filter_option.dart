import 'package:flutter/material.dart';

class FilterOption extends StatefulWidget {
  const FilterOption({
    required this.filterText,
    required this.duration,
    this.curve = Curves.easeInOut,
    this.filterColor = Colors.blue,
    this.backgroundColor = Colors.white,
    this.unselectedFilterTextColor = Colors.black87,
    this.selectedFilterTextColor = Colors.white,
    this.borderColor = Colors.black12,
    this.fontSize = 20,
    this.filterHeight = 50,
    this.filterDotDiameter = 20,
    this.filterPadding = 15,
    this.borderRadius = 25,
    this.borderWidth = 1,
    this.isSelected = false,
    required this.onTap,
  });

  final String filterText;
  final Color filterColor,
      backgroundColor,
      unselectedFilterTextColor,
      selectedFilterTextColor,
      borderColor;
  final Duration duration;
  final Curve curve;
  final double fontSize,
      filterHeight,
      filterDotDiameter,
      filterPadding,
      borderRadius,
      borderWidth;
  final bool isSelected;
  final void Function(bool) onTap;

  @override
  _FilterOptionState createState() => _FilterOptionState();
}

class _FilterOptionState extends State<FilterOption>
    with SingleTickerProviderStateMixin {
  final _parentContainer = GlobalKey(debugLabel: 'parent container');
  RenderBox? _renderBox;

  late AnimationController _animationController;
  late Animation<double> _textShiftAnimation;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _fillHeightAnimation;
  late Animation<double> _paddingAnimation;
  late Animation<Color?> _textColorAnimation;

  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _textShiftAnimation = Tween<double>(
      begin: 0,
      end: widget.filterDotDiameter + widget.filterPadding,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    ));

    _iconScaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceIn,
    ));

    _fillHeightAnimation = Tween<double>(
      begin: widget.filterDotDiameter,
      end: widget.filterHeight,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    ));

    _paddingAnimation = Tween<double>(
      begin: widget.filterPadding,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    ));

    _textColorAnimation = ColorTween(
      begin: widget.unselectedFilterTextColor,
      end: widget.selectedFilterTextColor,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    ));
  }

  Animation<double> get _fillWidthAnimation {
    _renderBox =
        _parentContainer.currentContext!.findRenderObject() as RenderBox?;
    var width =
        _renderBox != null ? _renderBox!.size.width : widget.filterDotDiameter;
    return Tween<double>(
      begin: widget.filterDotDiameter,
      end: width,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _parentContainer,
      height: widget.filterHeight,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: widget.borderColor,
          width: widget.borderWidth,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: GestureDetector(
          onTap: () {
            switch (_animationController.status) {
              case AnimationStatus.completed:
                _animationController.reverse();
                break;
              case AnimationStatus.dismissed:
                _animationController.forward();
                break;
              default:
                return;
            }
            setState(() {
              _isSelected = !_isSelected;
              widget.onTap(_isSelected);
            });
          },
          child: Stack(
            children: <Widget>[
              _buildFilterState(),
              _buildFilterText(),
              _buildFilterClear(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterState() => AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) => Positioned(
          left: _paddingAnimation.value,
          top: _paddingAnimation.value,
          child: Container(
            height: _fillHeightAnimation.value,
            width: _fillWidthAnimation.value,
            decoration: BoxDecoration(
              color: widget.filterColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
          ),
        ),
      );

  double get _initTextLeftPadding =>
      widget.filterDotDiameter + 2 * widget.filterPadding;

  Widget _buildFilterText() => AnimatedBuilder(
        animation: _animationController,
        builder: (_, child) => Align(
          widthFactor: 1,
          child: Padding(
            padding: EdgeInsets.only(
              left: _initTextLeftPadding - _textShiftAnimation.value,
              right: widget.filterPadding + _textShiftAnimation.value,
            ),
            child: Text(
              widget.filterText,
              style: TextStyle(
                color: _textColorAnimation.value,
                fontSize: widget.fontSize,
              ),
            ),
          ),
        ),
      );

  Widget _buildFilterClear() => Positioned(
        right: widget.filterPadding,
        top: widget.filterPadding,
        child: ScaleTransition(
          scale: _iconScaleAnimation,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(1),
            child: Icon(
              Icons.clear,
              color: widget.filterColor,
              size: widget.filterDotDiameter - 2,
            ),
          ),
        ),
      );
}
