import 'dart:math' show Random;
import 'package:flutter/material.dart';

enum DownloadStatus {
  cancelled, // not downloaded state or when download is cancelled
  preparing, // preparing for download
  fetching, // downloading
  downloaded, // finished downloading
}

// create an abstract class to avoid exposing intricate details about
// implementation of download simulation. Keep it simple.
abstract class DownloadController implements ChangeNotifier {
  DownloadStatus get status;
  double get progress;

  void start();
  void cancel();
  void open();
}

// to simulate random behavior for progress and pause duration
final _random = Random(DateTime.now().millisecondsSinceEpoch);

class SimulatedDownloadController extends DownloadController
    with ChangeNotifier {
  SimulatedDownloadController({
    required VoidCallback onOpen,
    double progress = 0.0,
    DownloadStatus status = DownloadStatus.cancelled,
  })  : _onOpen = onOpen,
        _progress = progress,
        _status = status;

  DownloadStatus _status;
  double _progress;
  VoidCallback _onOpen; // action performed after download is ready
  final _pauses = _random.nextInt(5);

  @override
  DownloadStatus get status => _status;
  @override
  double get progress => _progress;

  @override
  void start() {
    if (_status == DownloadStatus.cancelled) _simulateStart();
  }

  // generate a random duration amount at each pause in downloading state
  Duration get _duration => Duration(milliseconds: _random.nextInt(700) + 300);

  // generate random sequential [values] between 0.0 and 1.0 based on [_pauses]
  List<double> get _milestones {
    var values = List<double>.filled(_pauses + 2, 0, growable: false);
    var prev = 0.0, limit = 1.0 / _pauses;
    for (var i = 1; i <= _pauses; i++) {
      var curr = prev + _random.nextDouble() * limit;
      values[i] = curr;
      prev = curr;
    }
    values[_pauses + 1] = 1;
    return values;
  }

  void _simulateStart() async {
    _status = DownloadStatus.preparing;
    notifyListeners();
    await Future.delayed(_duration);
    _status = DownloadStatus.fetching;
    notifyListeners();

    for (final curr in _milestones) {
      await Future.delayed(_duration);
      // check if the download has been cancelled in between the delay
      if (_status == DownloadStatus.cancelled) return;
      _progress = curr;
      notifyListeners();
    }

    await Future.delayed(_duration);
    if (_status == DownloadStatus.cancelled) return;
    _status = DownloadStatus.downloaded;
    notifyListeners();
  }

  @override
  void cancel() {
    if (_status == DownloadStatus.fetching) {
      _progress = 0;
      _status = DownloadStatus.cancelled;
      notifyListeners();
    }
  }

  @override
  void open() {
    if (status == DownloadStatus.downloaded) _onOpen();
  }
}
