import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Light extends ConsumerWidget {
  final Color color;

  const Light({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
