import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traffic_lights/modules/traffic_lights/providers/traffic_lights_provider.dart';
import 'package:traffic_lights/modules/traffic_lights/widgets/traffic_light_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  int get _numberOfColumns => 5;
  double get itemPadding => 8;
  double get fixedItemHeight => 240;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trafficLights = ref.watch(trafficLightsProvider);
    final isChaos = ref.watch(trafficLightsProvider.notifier).isChaos;

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              ref.read(trafficLightsProvider.notifier).changeMode(!isChaos);
            },
            child: Text(isChaos ? 'Synchronize' : 'Chaos'),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _numberOfColumns,
          crossAxisSpacing: itemPadding,
          mainAxisExtent: fixedItemHeight,
          mainAxisSpacing: itemPadding,
          childAspectRatio: 1,
        ),
        itemCount: trafficLights.length,
        itemBuilder: (context, index) {
          final trafficLight = trafficLights[index];
          return TrafficLightWidget(trafficLight: trafficLight);
        },
      ),
    );
  }
}
