import 'package:flutter/material.dart';
import 'package:flutter_samples/google_io_filter/filter_option.dart';

void main() => runApp(GoogleIOFilter());

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
                filterColor: Colors.deepPurple.shade300,
                onTap: (val) => print(val),
              ),
              FilterOption(
                duration: Duration(milliseconds: 600),
                filterText: 'flutter',
                unselectedFilterTextColor: Colors.indigo.shade300,
                filterColor: Colors.indigo.shade300,
                onTap: (val) => print(val),
              ),
              FilterOption(
                duration: Duration(milliseconds: 900),
                filterText: 'Go',
                unselectedFilterTextColor: Colors.teal.shade300,
                filterColor: Colors.teal.shade300,
                onTap: (val) => print(val),
              ),
              FilterOption(
                duration: Duration(milliseconds: 1200),
                filterText: 'Python',
                unselectedFilterTextColor: Colors.blue.shade300,
                filterColor: Colors.amber.shade300,
                onTap: (val) => print(val),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
