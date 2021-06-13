import 'package:flutter/material.dart';

import '../download_simulator/download_controller.dart' show DownloadStatus;

class IOSDownloadButton extends StatelessWidget {
  static const bgColor = Color(0xffE6E6EC);
  static const textColor = Color(0xff87BBF3);

  final Duration transitionDuration;
  final DownloadStatus status;
  final double progress;
  final VoidCallback onStart, onCancel, onOpen;

  const IOSDownloadButton({
    Key? key,
    required this.status,
    required this.onStart,
    required this.onCancel,
    required this.onOpen,
    this.progress = 0,
    this.transitionDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  bool get _isPreparing => status == DownloadStatus.preparing;
  bool get _isFetching => status == DownloadStatus.fetching;
  bool get _isDownloaded => status == DownloadStatus.downloaded;

  void _onPressed() {
    switch (status) {
      case DownloadStatus.cancelled:
        onStart();
        break;
      case DownloadStatus.preparing:
        break;
      case DownloadStatus.fetching:
        onCancel();
        break;
      case DownloadStatus.downloaded:
        onOpen();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressed,
      child: Stack(
        children: [
          _buildButton(child: _buildText()),
          _buildDownloadingProgress(),
        ],
      ),
    );
  }

  Widget _buildButton({required Widget child}) {
    return AnimatedContainer(
      duration: transitionDuration,
      curve: Curves.fastOutSlowIn,
      child: child,
      width: double.infinity,
      decoration: _isPreparing || _isFetching
          ? const ShapeDecoration(
              shape: CircleBorder(),
              color: Colors.transparent,
            )
          : const ShapeDecoration(
              shape: StadiumBorder(),
              color: IOSDownloadButton.bgColor,
            ),
    );
  }

  Widget _buildText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: AnimatedOpacity(
        duration: transitionDuration,
        opacity: _isPreparing || _isFetching ? 0 : 1,
        curve: Curves.easeOut,
        child: Text(
          _isDownloaded ? 'OPEN' : 'GET',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: IOSDownloadButton.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadingProgress() {
    return Positioned.fill(
      child: AnimatedOpacity(
        duration: transitionDuration,
        curve: Curves.easeOut,
        opacity: _isPreparing || _isFetching ? 1 : 0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildProgressIndicator(),
            if (_isFetching)
              const Icon(
                Icons.stop,
                size: 14,
                color: IOSDownloadButton.textColor,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return AspectRatio(
      aspectRatio: 1,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: progress),
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        builder: (_, value, child) {
          return CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor:
                _isFetching ? IOSDownloadButton.bgColor : Colors.transparent,
            valueColor: AlwaysStoppedAnimation(_isPreparing
                ? IOSDownloadButton.bgColor
                : IOSDownloadButton.textColor),
            value: _isPreparing ? null : value,
          );
        },
      ),
    );
  }
}
