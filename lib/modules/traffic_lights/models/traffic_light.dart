import 'package:traffic_lights/modules/traffic_lights/models/traffic_color.dart';

class TrafficLight {
  final TrafficColor color;

  TrafficLight({
    required this.color,
  });

  TrafficLight copyWith({
    TrafficColor? color,
  }) {
    return TrafficLight(
      color: color ?? this.color,
    );
  }
}
