import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import './collapsable_side_bar.dart';
import './item.dart';

class SideBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.blueGrey[100],
            ),
            Padding(
              padding: EdgeInsets.all(4),
              child: CollapsableSideBar(
                name: 'Hauntarl',
                imageUrl: _imageUrl,
                items: _items,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<Item> _items = [
    Item(
      title: 'Dashboard',
      icon: Icons.assessment,
      onPressed: () {},
    ),
    Item(
      title: 'Errors',
      icon: Icons.cancel,
      onPressed: () {},
    ),
    Item(
      title: 'Search',
      icon: Icons.search,
      onPressed: () {},
    ),
    Item(
      title: 'Notifications',
      icon: Icons.notifications,
      onPressed: () {},
    ),
    Item(
      title: 'Settings',
      icon: Icons.settings,
      onPressed: () {},
    ),
  ];
}

const _imageUrl =
    'https://raw.githubusercontent.com/hauntarl/flutter_samples/master/assets/bleach.png';
