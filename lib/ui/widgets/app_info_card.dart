import 'package:flutter/material.dart';

class InfoCardWithIcon extends TextButton {
  InfoCardWithIcon(
      {super.key,
      required super.onPressed,
      Color? color,
      required String title,
      required String description,
      required IconData icon})
      : super(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  color: color ?? Colors.white24,
                  width: 1,
                ),
              ),
            ),
            child: SizedBox(
              width: 125,
              height: 125,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 30,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ]),
            ));

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
