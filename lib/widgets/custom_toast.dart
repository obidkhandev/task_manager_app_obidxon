import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ToastType { success, error, info }

class CustomToast {
  static OverlayEntry? _currentToast;
  static Timer? _dismissTimer;
  static Timer? _vibrationTimer;

  static void showSuccess(BuildContext context, String message, {String? title}) {
    _showToast(
      context,
      type: ToastType.success,
      title: title ?? 'Success',
      message: message,
    );
  }

  static void showError(BuildContext context, String message, {String? title}) {
    _showToast(
      context,
      type: ToastType.error,
      title: title ?? 'Error',
      message: message,
    );
  }

  static void showInfo(BuildContext context, String message, {String? title}) {
    _showToast(
      context,
      type: ToastType.info,
      title: title ?? 'Info',
      message: message,
    );
  }

  static void _showToast(
    BuildContext context, {
    required ToastType type,
    required String title,
    required String message,
  }) {
    _currentToast?.remove();
    _currentToast = null;
    _dismissTimer?.cancel();
    _vibrationTimer?.cancel();

    final overlay = Overlay.of(context);
    if (overlay == null) return;

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        type: type,
        title: title,
        message: message,
        onDismiss: () {
          overlayEntry.remove();
          _currentToast = null;
          _dismissTimer?.cancel();
          _vibrationTimer?.cancel();
        },
      ),
    );

    overlay.insert(overlayEntry);
    _currentToast = overlayEntry;

    _dismissTimer = Timer(const Duration(seconds: 3), () {
      overlayEntry.remove();
      _currentToast = null;
      _vibrationTimer?.cancel();
    });

    if (type == ToastType.error) {
      _startErrorVibration();
    }
  }

  static void _startErrorVibration() {
    _vibrationTimer?.cancel();
    int vibrationCount = 0;
    const maxVibrations = 3;

    void vibrate() {
      if (vibrationCount < maxVibrations) {
        HapticFeedback.mediumImpact();
        vibrationCount++;
        _vibrationTimer = Timer(const Duration(milliseconds: 150), vibrate);
      }
    }

    Timer(const Duration(milliseconds: 100), vibrate);
  }
}

class _ToastWidget extends StatefulWidget {
  const _ToastWidget({
    required this.type,
    required this.title,
    required this.message,
    required this.onDismiss,
  });

  final ToastType type;
  final String title;
  final String message;
  final VoidCallback onDismiss;

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _dismiss() async {
    await _controller.reverse();
    if (mounted) widget.onDismiss();
  }

  ToastConfig get _config {
    switch (widget.type) {
      case ToastType.success:
        return ToastConfig(
          backgroundColor: const Color(0xFFF6FFF9),
          borderColor: const Color(0xFF48C1B5),
          gradientStart: const Color(0xFF48CA93),
          gradientEnd: const Color(0xFF48BACA),
          icon: Icons.check_circle,
        );
      case ToastType.error:
        return ToastConfig(
          backgroundColor: const Color(0xFFFEF3F2),
          borderColor: const Color(0xFFFECDCA),
          gradientStart: const Color(0xFFF04438),
          gradientEnd: const Color(0xFFD92D20),
          icon: Icons.error,
        );
      case ToastType.info:
        return ToastConfig(
          backgroundColor: const Color(0xFFEFF8FF),
          borderColor: const Color(0xFFB2DDFF),
          gradientStart: const Color(0xFF1570EF),
          gradientEnd: const Color(0xFF175CD3),
          icon: Icons.info,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = _config;
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.padding.top;

    return Positioned(
      top: topPadding + 16,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: config.backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: config.borderColor,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [config.gradientStart, config.gradientEnd],
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Icon(
                        config.icon,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                            color: Color(0xFF27303A),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.message,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 1.6,
                            color: Color(0xFF2F3F53),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _dismiss,
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: Color(0xFF667085),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ToastConfig {
  const ToastConfig({
    required this.backgroundColor,
    required this.borderColor,
    required this.gradientStart,
    required this.gradientEnd,
    required this.icon,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color gradientStart;
  final Color gradientEnd;
  final IconData icon;
}

