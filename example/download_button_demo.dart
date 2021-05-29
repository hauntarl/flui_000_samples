import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_samples/download_button/download_button.dart';
import 'package:flutter_samples/download_simulator/download_controller.dart';

void main() => runApp(HomePage());

// https://flutter.dev/docs/cookbook/effects/download-button
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('Apps'), centerTitle: true),
        body: Applist(),
      ),
    );
  }
}

class Applist extends StatefulWidget {
  @override
  _ApplistState createState() => _ApplistState();
}

class _ApplistState extends State<Applist> {
  static const List<String> _names = [
    'Retail Hut',
    'Comstore',
    'cartsell',
    'grock',
    'butchine',
    'factore',
    'cardpile',
    'stery',
    'quanter',
    'sechshop',
  ];
  static const List<String> _desc = [
    'Ergonomic executive chair upholstered in bonded black leather and PVC padded seat and back for all-day comfort and support',
    'Carbonite web goalkeeper gloves are ergonomically designed to give easy fit',
    'The Nagasaki Lander is the trademarked name of several series of Nagasaki sport bikes, that started with the 1984 ABC800J',
    'New ABC 13 9370, 13.3, 5th Gen CoreA5-8250U, 8GB RAM, 256GB SSD, power UHD Graphics, OS 10 Home, OS Office A & J 2016',
    'The Football Is Good For Training And Recreational Purposes',
    'The automobile layout consists of a front-engine design, with transaxle-type transmissions mounted at the rear of the engine and four wheel drive',
    'New range of formal shirts are designed keeping you in mind. With fits and styling that will make you stand apart',
    'The slim & simple Maple Gaming Keyboard from Dev Byte comes with a sleek body and 7- Color RGB LED Back-lighting for smart functionality',
    'Boston\'s most advanced compression wear technology increases muscle oxygenation, stabilizes active muscles',
    'Andy shoes are designed to keeping in mind durability as well as trends, the most stylish range of shoes & sandals',
  ];
  late final List<DownloadController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      20,
      (index) => SimulatedDownloadController(
        onOpen: () => _openDownload(index),
      ),
    );
  }

  void _openDownload(int index) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Open App: ${_names[index % _names.length]}'),
    ));
  }

  Widget _buildList() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: _buildListItem,
      separatorBuilder: (_, __) => const Divider(indent: 50, endIndent: 50),
      itemCount: _controllers.length,
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    final controller = _controllers[index];
    return ListTile(
      leading: AppIcon(),
      title: Text(
        '${_names[index % _names.length]}',
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text(
        '${_desc[index % _desc.length]}',
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.caption,
      ),
      trailing: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          print('${controller.status}: ${controller.progress}');
          return SizedBox(
            width: 96,
            child: DownloadButton(
              status: controller.status,
              progress: controller.progress,
              onStart: controller.start,
              onCancel: controller.cancel,
              onOpen: controller.open,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }
}

class AppIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final endColor = Theme.of(context).backgroundColor;
    return AspectRatio(
      aspectRatio: 1,
      child: SizedBox(
        height: 80,
        width: 80,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(colors: [
              Colors.white,
              Colors.white,
              endColor.withOpacity(0.25),
              endColor,
            ]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Align(
            alignment: Alignment(-0.1, 0),
            child: FlutterLogo(size: 25),
          ),
        ),
      ),
    );
  }
}
