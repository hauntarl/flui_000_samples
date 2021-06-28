import 'package:flutter/material.dart';
import 'package:flutter_samples/nested_navigation/home_page.dart';
import 'package:flutter_samples/nested_navigation/routes.dart';
import 'package:flutter_samples/nested_navigation/settings_page.dart';
import 'package:flutter_samples/nested_navigation/setup_flow.dart';

void main() => runApp(NestedNavigation());

// tutorial: https://flutter.dev/docs/cookbook/effects/nested-nav
class NestedNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(backgroundColor: const Color(0xFF222222)),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color(0xFF222222),
        ),
      ),
      onGenerateRoute: (settings) {
        late Widget page;
        if (settings.name == routeHome) {
          page = HomePage();
        } else if (settings.name == routeSettings) {
          page = SettingsPage();
        } else if (settings.name!.startsWith(routePrefixDeviceSetup)) {
          page = SetupFlow(
            setupPageRoute: settings.name!.substring(
              routePrefixDeviceSetup.length,
            ),
          );
        } else
          throw Exception('Unknown route: ${settings.name}');

        return MaterialPageRoute(
          settings: settings,
          builder: (_) => page,
        );
      },
    );
  }
}
