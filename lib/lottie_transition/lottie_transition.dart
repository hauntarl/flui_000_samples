import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

import './lottie_painter.dart';

class LottieTransition extends AnimatedWidget {
  final LottieComposition composition;
  final Size size;

  const LottieTransition({
    Key? key,
    required Animation<double> animation,
    required this.composition,
    this.size = const Size(300, 300),
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final progress = listenable as Animation<double>;
    return CustomPaint(
      size: size,
      painter: LottiePainter(
        composition: composition,
        progress: progress.value,
      ),
    );
  }
}
