import 'package:flutter/material.dart';

import './item.dart';

class CollapsableSideBar extends StatelessWidget {
  const CollapsableSideBar({
    @required this.name,
    @required this.imageUrl,
    @required this.items,
    this.width = 250,
    this.height = double.infinity,
    this.borderRadius = 15,
    this.imageSize = 40,
    this.menuIcon = Icons.more_vert,
    this.dropdownIcon = Icons.arrow_drop_down,
    this.backgroundColor = const Color(0xff2B3138),
    this.selectedItemColor = const Color(0xff2F4047),
    this.selectedIconColor = const Color(0xff4AC6EA),
    this.selectedTextColor = const Color(0xffF3F7F7),
    this.unselectedIconColor = const Color(0xff6A7886),
    this.unselectedTextColor = const Color(0xffC0C7D0),
    this.dropdownButtonColor = const Color(0xff30383F),
    this.textStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
  });

  final String imageUrl, name;
  final List<Item> items;
  final double width, height, borderRadius, imageSize;
  final IconData menuIcon, dropdownIcon;
  final Color backgroundColor,
      selectedItemColor,
      selectedIconColor,
      selectedTextColor,
      unselectedIconColor,
      unselectedTextColor,
      dropdownButtonColor;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor,
      ),
    );
  }

  Widget get _displayImage {
    return ClipRRect(
      borderRadius: BorderRadius.circular(imageSize),
      child: Image.network(
        imageUrl,
        fit: BoxFit.fill,
        height: imageSize,
        width: imageSize,
      ),
    );
  }
}
