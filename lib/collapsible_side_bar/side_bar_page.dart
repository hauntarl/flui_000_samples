import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import './collapsible_side_bar.dart';
import './item.dart';

class SideBarPage extends StatefulWidget {
  @override
  _SideBarPageState createState() => _SideBarPageState();
}

class _SideBarPageState extends State<SideBarPage> {
  var pageTitle = 'Errors';
  List<Item> _items;

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    var size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.blueGrey[100],
          child: Center(
            child: Transform.rotate(
              angle: math.pi / 2,
              child: Transform.translate(
                offset: Offset(-size.height * 0.2, -size.width * 0.3),
                child: Text(
                  pageTitle,
                  style: Theme.of(context).textTheme.headline1,
                  overflow: TextOverflow.visible,
                  softWrap: false,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(4),
          child: _sideBar(context, size.width),
        ),
      ],
    );
  }

  Widget _sideBar(BuildContext context, double width) {
    return CollapsibleSideBar(
      maxWidth: width * 0.75,
      items: _items,
      avatarUrl: _avatarUrl,
      name: 'Sameer Mungole',
    );
  }

  List<Item> get _generateItems {
    return [
      Item(
        title: 'Dashboard',
        icon: Icons.assessment,
        onPressed: () => setState(() => pageTitle = 'DashBoard'),
      ),
      Item(
        title: 'Errors',
        icon: Icons.cancel,
        onPressed: () => setState(() => pageTitle = 'Errors'),
        isSelected: true,
      ),
      Item(
        title: 'Search',
        icon: Icons.search,
        onPressed: () => setState(() => pageTitle = 'Search'),
      ),
      Item(
        title: 'Notifications',
        icon: Icons.notifications,
        onPressed: () => setState(() => pageTitle = 'Notifications'),
      ),
      Item(
        title: 'Settings',
        icon: Icons.settings,
        onPressed: () => setState(() => pageTitle = 'Settings'),
      ),
    ];
  }
}

const _avatarUrl =
    'https://raw.githubusercontent.com/hauntarl/flutter_samples/master/assets/bleach.png';
