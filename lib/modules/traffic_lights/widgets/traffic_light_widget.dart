import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traffic_lights/modules/traffic_lights/models/traffic_light.dart';
import 'package:traffic_lights/modules/traffic_lights/widgets/light.dart';

class TrafficLightWidget extends ConsumerWidget {
  final TrafficLight trafficLight;

  const TrafficLightWidget({
    super.key,
    required this.trafficLight,
  });

  EdgeInsets get _padding => EdgeInsets.all(4);
  EdgeInsets get _colorPadding => EdgeInsets.only(top: 4);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 100,
      padding: _padding,
      color: Colors.grey,
      child: Column(
        children: [
          Padding(
            padding: _colorPadding,
            child: Light(
              color: trafficLight.color.needRedLight
                  ? Colors.red
                  : Colors.red.shade100,
            ),
          ),
          Padding(
            padding: _colorPadding,
            child: Light(
              color: trafficLight.color.needYellowLight
                  ? Colors.yellowAccent
                  : Colors.yellow.shade100,
            ),
          ),
          Padding(
            padding: _colorPadding,
            child: Light(
              color: trafficLight.color.needGreenLight
                  ? Colors.green
                  : Colors.green.shade100,
            ),
          ),
        ],
      ),
    );
  }
}
