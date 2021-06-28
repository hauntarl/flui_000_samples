import 'package:flutter/material.dart';
import 'package:flutter_samples/nested_navigation/finished_page.dart';

import './routes.dart';
import './select_device_page.dart';
import './waiting_page.dart';

class SetupFlow extends StatefulWidget {
  final String setupPageRoute;

  const SetupFlow({Key? key, required this.setupPageRoute}) : super(key: key);

  @override
  _SetupFlowState createState() => _SetupFlowState();
}

class _SetupFlowState extends State<SetupFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _confirmExit,
      child: Scaffold(
        appBar: _buildAppBar,
        body: Navigator(
          key: _navigatorKey,
          initialRoute: widget.setupPageRoute,
          onGenerateRoute: _onGenerateRoute,
        ),
      ),
    );
  }

  Future<bool> _confirmExit() async {
    final dialog = showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('are you sure'),
        content: Text('if you exit device setup, your progress will be lost'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('leave'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('stay'),
          ),
        ],
      ),
    );
    return await dialog ?? false;
  }

  PreferredSizeWidget get _buildAppBar {
    return AppBar(
      title: const Text('Bulb Setup'),
      leading: IconButton(
        onPressed: _onExitPressed,
        icon: Icon(Icons.chevron_left),
      ),
    );
  }

  Future<void> _onExitPressed() async {
    if (await _confirmExit() && mounted) _exitSetup();
  }

  void _exitSetup() => Navigator.of(context).pop();

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;
    print('Level 2: ${settings.name}');
    switch (settings.name) {
      case routeDeviceSetupStartPage:
        page = WaitingPage(
          message: 'searching for nearby bulbs',
          onWaitComplete: _onSearchComplete,
        );
        break;
      case routeDeviceSetupSelectDevicePage:
        page = SelectDevicePage(onDeviceSelected: _onDeviceSelected);
        break;
      case routeDeviceSetupConnectingPage:
        page = WaitingPage(
          message: 'connecting...',
          onWaitComplete: _onConnectionEstablished,
        );
        break;
      case routeDeviceSetupFinishedPage:
        page = FinishedPage(onFinishPressed: _exitSetup);
        break;
    }

    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }

  void _onSearchComplete() {
    _navigatorKey.currentState!.pushNamed(routeDeviceSetupSelectDevicePage);
  }

  void _onDeviceSelected(String id) {
    _navigatorKey.currentState!.pushNamed(routeDeviceSetupConnectingPage);
  }

  void _onConnectionEstablished() {
    _navigatorKey.currentState!.pushNamed(routeDeviceSetupFinishedPage);
  }
}
