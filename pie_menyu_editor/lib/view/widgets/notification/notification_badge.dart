import 'package:flutter/material.dart';
import 'package:spring/spring.dart';

import 'notification.dart';

class NotificationBadge extends StatelessWidget {
  final NotificationDelegate notification;

  const NotificationBadge({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: notification.message,
      child: (btn) {
        return notification.curve != null
            ? Spring.blink(child: btn, curve: notification.curve!)
            : btn;
      }(
        TextButton(
          onPressed: notification.onPressed,
          style: TextButton.styleFrom(
            backgroundColor: notification.type.color.withOpacity(0.3),
            foregroundColor: notification.type.color,
            padding: const EdgeInsets.all(0),
            minimumSize: const Size(32, 32),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          child: notification.icon,
        ),
      ),
    );
  }
}
