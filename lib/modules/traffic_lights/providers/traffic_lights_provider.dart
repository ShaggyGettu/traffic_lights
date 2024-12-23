import 'dart:async';
import 'dart:math';

import 'package:fimber/fimber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synchronized/synchronized.dart';
import 'package:traffic_lights/modules/traffic_lights/models/traffic_color.dart';
import 'package:traffic_lights/modules/traffic_lights/models/traffic_light.dart';

final trafficLightsProvider =
    StateNotifierProvider<TrafficLightsNotifier, List<TrafficLight>>(
  (ref) => TrafficLightsNotifier(),
);

class TrafficLightsNotifier extends StateNotifier<List<TrafficLight>> {
  final _logger = FimberLog('TrafficLightsNotifier');
  final _modLock = Lock();
  bool _isChaos = true;
  Timer? _syncTimer;
  final _timers = <Timer>[];

  TrafficLightsNotifier() : super([]) {
    _logger.i('TrafficLightsNotifier created');
    for (int i = 0; i < _numbersOfLights; ++i) {
      _timers.add(Timer(Duration.zero, () {}));
    }
    chaosTrafficLights();
  }

  bool get isChaos => _isChaos;
  int get _numbersOfLights => 1000;
  int get _maxDelayMilli => 5000;

  void changeMode(bool isChaos) {
    if (isChaos) {
      _modLock.synchronized(() {
        chaosTrafficLights();
      }, timeout: Duration(milliseconds: 100));
    } else {
      _modLock.synchronized(() {
        syncTrafficLights();
      }, timeout: Duration(milliseconds: 100));
    }
  }

  Future<void> chaosTrafficLights() async {
    _logger.i('chaosTrafficLights');
    _syncTimer?.cancel();
    _isChaos = true;
    final list = <TrafficLight>[];
    for (int i = 0; i < _numbersOfLights; ++i) {
      if (!_isChaos) {
        break;
      }
      list.add(
        TrafficLight(
          color: TrafficColor.red,
          isOn: false,
        ),
      );
      final randomDelay = Duration(
        milliseconds: (Random().nextDouble() * _maxDelayMilli).round(),
      );

      Future.delayed(randomDelay, () {
        final list = [...state];
        list[i] = list[i].copyWith(
          color: list[i].color,
          isOn: true,
        );
        state = list;
        runColor(i);
      });
    }
    if (_isChaos) {
      state = list;
    }
  }

  void runColor(int index) {
    _timers[index] = Timer.periodic(Duration(milliseconds: 1500), (timer) {
      final list = [...state];
      if (!_isChaos) {
        timer.cancel();
        return;
      }
      final newTl = newTrafficLight(list[index], timer.tick);
      list[index] = newTl;
      state = list;
    });
  }

  Future<void> syncTrafficLights() async {
    _logger.i('syncTrafficLights');
    for (final timer in _timers) {
      timer.cancel();
    }
    _isChaos = false;
    final list = <TrafficLight>[];
    for (int i = 0; i < _numbersOfLights; ++i) {
      list.add(
        TrafficLight(
          color: TrafficColor.red,
        ),
      );
    }
    state = list;
    runColors();
  }

  // For synchronized traffic lights
  void runColors() {
    _syncTimer = Timer.periodic(Duration(milliseconds: 1500), (timer) {
      final list = [...state];
      if (_isChaos) {
        timer.cancel();
        return;
      }
      for (int i = 0; i < list.length; ++i) {
        final newTl = newTrafficLight(list[i], timer.tick);
        list[i] = newTl;
      }
      state = list;
    });
  }

  @override
  void dispose() {
    _syncTimer?.cancel();
    for (final timer in _timers) {
      timer.cancel();
    }
    super.dispose();
  }

  newTrafficLight(TrafficLight list, int tick) {
    if (tick % 6 == 1 || tick % 6 == 2) {
      return list.copyWith(color: TrafficColor.red);
    } else if (tick % 6 == 3) {
      return list.copyWith(color: TrafficColor.redYellow);
    } else if (tick % 6 == 4 || tick % 6 == 5) {
      return list.copyWith(color: TrafficColor.green);
    } else if (tick % 6 == 0) {
      return list.copyWith(color: TrafficColor.yellow);
    }
  }
}
