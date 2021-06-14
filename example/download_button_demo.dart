import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_samples/download_button/ios_download_button.dart';
import 'package:flutter_samples/download_button/lottie_download_button.dart';
import 'package:flutter_samples/download_simulator/download_controller.dart';

void main() => runApp(DownloadButtonDemo());

// https://flutter.dev/docs/cookbook/effects/download-button
class DownloadButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Download Simulator',
            style: TextStyle(color: Colors.black54),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButtons(),
              _buildText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return LayoutBuilder(
      builder: (context, _) {
        var controller = SimulatedDownloadController(
          onOpen: () => _openDownload(context),
        );
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIOSButton(controller),
            _buildLottieButton(controller),
          ],
        );
      },
    );
  }

  void _openDownload(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Open App'),
    ));
  }

  Widget _buildIOSButton(DownloadController controller) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return SizedBox(
          width: 150,
          child: IOSDownloadButton(
            status: controller.status,
            progress: controller.progress,
            onStart: controller.start,
            onCancel: controller.cancel,
            onOpen: controller.open,
          ),
        );
      },
    );
  }

  Widget _buildLottieButton(DownloadController controller) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) => LottieDownloadButton(
        size: const Size(150, 150),
        status: controller.status,
        progress: controller.progress,
        onStart: controller.start,
        onCancel: controller.cancel,
        onOpen: controller.open,
        onReset: controller.reset,
      ),
    );
  }

  Widget _buildText() {
    const style = TextStyle(
      fontSize: 16,
      color: Colors.black54,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('iOS Download Button', style: style),
        Text('Lottie Download Button', style: style),
      ],
    );
  }
}
