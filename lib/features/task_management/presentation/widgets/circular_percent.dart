import 'dart:math' as math;

import 'package:flutter/material.dart';

class CircularPercent extends StatelessWidget {
  const CircularPercent({
    super.key,
    required this.percent, // 0..1
    required this.label,
    this.size = 100,
    this.strokeWidth = 8,
    this.duration = const Duration(milliseconds: 700),
    this.curve = Curves.easeOutCubic,
    this.trackColor,
    this.progressColor,
    this.backgroundCircleColor = const Color(0x306C5CE7),
    this.labelStyle = const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  });

  final double percent;
  final String label;

  final double size;
  final double strokeWidth;
  final Duration duration;
  final Curve curve;
  final Color? trackColor;
  final Color? progressColor;
  final Color backgroundCircleColor;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    final clamped = percent.clamp(0.0, 1.0);
    final Color effectiveTrack = trackColor ?? Colors.white.withOpacity(0.25);
    final Color effectiveProgress = progressColor ?? Colors.white;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Subtle background fill matching the original design
          Container(
            decoration: BoxDecoration(
              color: backgroundCircleColor,
              shape: BoxShape.circle,
            ),
          ),
          // Animated progress arc
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: clamped),
            duration: duration,
            curve: curve,
            builder: (context, value, _) {
              return CustomPaint(
                size: Size.square(size),
                painter: _CircularProgressPainter(
                  progress: value,
                  strokeWidth: strokeWidth,
                  trackColor: effectiveTrack,
                  progressColor: effectiveProgress,
                ),
              );
            },
          ),
          // Center label
          Text(label, style: labelStyle),
        ],
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  _CircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.trackColor,
    required this.progressColor,
  });

  final double progress; // 0..1
  final double strokeWidth;
  final Color trackColor;
  final Color progressColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Track
    canvas.drawCircle(center, radius, trackPaint);

    // Progress arc starting from top (-90 degrees)
    final startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.progressColor != progressColor;
  }
}

