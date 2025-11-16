import 'package:flutter/material.dart';

class SlideFadeIn extends StatelessWidget {
  const SlideFadeIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = const Offset(0, 0.06),
    this.duration = const Duration(milliseconds: 300),
  });

  final Widget child;
  final Duration delay;
  final Offset offset;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration,
      curve: Curves.easeOut,
      // delay: delay,easeOu
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(offset.dx * (1 - value) * 30, offset.dy * (1 - value) * 30),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

