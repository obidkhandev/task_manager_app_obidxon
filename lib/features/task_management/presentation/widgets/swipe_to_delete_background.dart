import 'package:flutter/material.dart';
import 'package:task_manager/generated/l10n.dart';


class SwipeToDeleteBackground extends StatelessWidget {
  const SwipeToDeleteBackground({super.key, this.alignment = Alignment.centerRight});

  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final isRight = alignment == Alignment.centerRight;
    final children = <Widget>[
      Icon(Icons.delete_outline, color: Colors.white),
      const SizedBox(width: 8),
      Text(S.of(context).delete, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
    ];
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.redAccent,
      child: Row(
        mainAxisAlignment: isRight ? MainAxisAlignment.end : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: isRight ? children : children.reversed.toList(),
      ),
    );
  }
}

