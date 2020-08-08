import 'package:flutter/material.dart';

import './widgets/filter_option_widget.dart';

class GoogleIOFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: FilterOption(
            duration: Duration(milliseconds: 300),
            filterText: 'filter option',
            filterColor: Colors.deepPurple[300],
            backgroundColor: Theme.of(context).canvasColor,
            onTap: (val) => print(val),
          ),
        ),
      ),
    );
  }
}
