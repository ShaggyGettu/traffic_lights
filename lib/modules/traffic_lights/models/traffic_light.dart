import 'package:traffic_lights/modules/traffic_lights/models/traffic_color.dart';

class TrafficLight {
  final TrafficColor color;
  final bool isOn;

  TrafficLight({
    required this.color,
    this.isOn = true,
  });

  TrafficLight copyWith({
    TrafficColor? color,
    bool? isOn,
  }) {
    return TrafficLight(
      color: color ?? this.color,
      isOn: isOn ?? this.isOn,
    );
  }
}
