import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_colors.dart';


class AnimatedFab extends StatefulWidget {
  const AnimatedFab({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  State<AnimatedFab> createState() => _AnimatedFabState();
}

class _AnimatedFabState extends State<AnimatedFab> with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 300))..forward();
  late final Animation<double> _scale = Tween(begin: 0.8, end: 1.0).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutBack,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: FloatingActionButton(
        onPressed: widget.onPressed,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
