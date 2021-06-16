import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';

class LottiePainter extends CustomPainter {
  final LottieDrawable drawable;
  final double progress;

  LottiePainter({
    required LottieComposition composition,
    required this.progress,
  }) : drawable = LottieDrawable(composition);

  @override
  void paint(Canvas canvas, Size size) {
    drawable
      ..setProgress(progress)
      ..draw(canvas, Offset.zero & size);
  }

  @override
  bool shouldRepaint(covariant LottiePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
