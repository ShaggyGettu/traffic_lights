enum TrafficColor {
  red,
  redYellow,
  green,
  yellow;

  TrafficColor next() {
    return TrafficColor.values[(index + 1) % TrafficColor.values.length];
  }

  bool get needRedLight =>
      this == TrafficColor.red || this == TrafficColor.redYellow;

  bool get needYellowLight =>
      this == TrafficColor.yellow || this == TrafficColor.redYellow;

  bool get needGreenLight => this == TrafficColor.green;
}
