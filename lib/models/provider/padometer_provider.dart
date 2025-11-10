import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/foundation.dart';
import 'package:sensors_plus/sensors_plus.dart';

class StepProvider extends ChangeNotifier {
  // Step counter
  int _stepCount = 0;
  int get stepCount => _stepCount;

  int _initialSteps = 0;
  bool _started = false;

  // Gyroscope
  double _gyroX = 0.0;
  double _gyroY = 0.0;
  double _gyroZ = 0.0;

  double get gyroX => _gyroX;
  double get gyroY => _gyroY;
  double get gyroZ => _gyroZ;

  StepProvider() {
    _initPedometer();
    _initGyroscope();
  }

  /// Initialize pedometer
  void _initPedometer() async {
    var status = await Permission.activityRecognition.request();
    if (!status.isGranted) {
      debugPrint("Permission not granted for activity recognition");
      return;
    }

    try {
      Pedometer.stepCountStream.listen(
            (event) {
          if (!_started) {
            _initialSteps = event.steps;
            _started = true;
            debugPrint('Initial steps recorded: $_initialSteps');
          }

          int newStepCount = event.steps - _initialSteps;
          if (_stepCount != newStepCount) {
            _stepCount = newStepCount;
            notifyListeners();
            debugPrint('Updated step count: $_stepCount');
          }
        },
        onError: (e) {
          debugPrint('Pedometer error: $e');
        },
      );
    } catch (e) {
      debugPrint('Failed to initialize pedometer: $e');
    }
  }

  /// Initialize gyroscope
  void _initGyroscope() {
    try {
      gyroscopeEvents.listen((GyroscopeEvent event) {
        _gyroX = event.x;
        _gyroY = event.y;
        _gyroZ = event.z;
        notifyListeners(); // Update UI whenever gyroscope changes
        debugPrint('Gyroscope x: $_gyroX, y: $_gyroY, z: $_gyroZ');
      });
    } catch (e) {
      debugPrint('Failed to initialize gyroscope: $e');
    }
  }
}

