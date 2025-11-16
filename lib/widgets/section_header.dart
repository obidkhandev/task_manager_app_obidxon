import 'package:flutter/material.dart';

import 'badge_pill.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, required this.count, this.padding});
  final String title;
  final int count;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          BadgePill(count: count),
        ],
      ),
    );
  }
}

