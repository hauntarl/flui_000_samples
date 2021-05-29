import 'package:flutter/material.dart';

import '../download_simulator/download_controller.dart' show DownloadStatus;

class DownloadButton extends StatefulWidget {
  static const bgColor = Color(0xffE6E6EC);
  static const textColor = Color(0xff87BBF3);

  final Duration transitionDuration;
  final DownloadStatus status;
  final double progress;
  final VoidCallback onStart, onCancel, onOpen;

  const DownloadButton({
    Key? key,
    required this.status,
    required this.onStart,
    required this.onCancel,
    required this.onOpen,
    this.progress = 0,
    this.transitionDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  _DownloadButtonState createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool get _isPreparing => widget.status == DownloadStatus.preparing;
  bool get _isFetching => widget.status == DownloadStatus.fetching;
  bool get _isDownloaded => widget.status == DownloadStatus.downloaded;

  void _onPressed() {
    switch (widget.status) {
      case DownloadStatus.cancelled:
        widget.onStart();
        break;
      case DownloadStatus.preparing:
        break;
      case DownloadStatus.fetching:
        widget.onCancel();
        break;
      case DownloadStatus.downloaded:
        widget.onOpen();
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
      duration: widget.transitionDuration,
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
              color: DownloadButton.bgColor,
            ),
    );
  }

  Widget _buildText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: AnimatedOpacity(
        duration: widget.transitionDuration,
        opacity: _isPreparing || _isFetching ? 0 : 1,
        curve: Curves.easeOut,
        child: Text(
          _isDownloaded ? 'OPEN' : 'GET',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: DownloadButton.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadingProgress() {
    return Positioned.fill(
      child: AnimatedOpacity(
        duration: widget.transitionDuration,
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
                color: DownloadButton.textColor,
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
        tween: Tween(begin: 0.0, end: widget.progress),
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        builder: (_, value, child) {
          return CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor:
                _isFetching ? DownloadButton.bgColor : Colors.transparent,
            valueColor: AlwaysStoppedAnimation(_isPreparing
                ? DownloadButton.bgColor
                : DownloadButton.textColor),
            value: _isPreparing ? null : value,
          );
        },
      ),
    );
  }
}
