import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class BadgePill extends StatelessWidget {
  const BadgePill({super.key, required this.count});
  final int count;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text('$count', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}

