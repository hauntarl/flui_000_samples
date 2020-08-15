import 'package:flutter/material.dart';

import './widgets/filter_option_widget.dart';

class GoogleIOFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 5,
            runSpacing: 10,
            children: [
              FilterOption(
                duration: Duration(milliseconds: 300),
                filterText: 'filter option',
                unselectedFilterTextColor: Colors.black54,
                filterColor: Colors.deepPurple[300],
                onTap: (val) => print(val),
              ),
              FilterOption(
                duration: Duration(milliseconds: 600),
                filterText: 'flutter',
                unselectedFilterTextColor: Colors.indigo[300],
                filterColor: Colors.indigo[300],
                onTap: (val) => print(val),
              ),
              FilterOption(
                duration: Duration(milliseconds: 900),
                filterText: 'Go',
                unselectedFilterTextColor: Colors.teal[300],
                filterColor: Colors.teal[300],
                onTap: (val) => print(val),
              ),
              FilterOption(
                duration: Duration(milliseconds: 1200),
                filterText: 'Python',
                unselectedFilterTextColor: Colors.blue[300],
                filterColor: Colors.amber[300],
                onTap: (val) => print(val),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
