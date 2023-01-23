import 'dart:io' as io;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  const AdaptiveFlatButton(
      {super.key, required this.text, required this.handler});

  final String text;
  final ui.VoidCallback handler;

  @override
  Widget build(BuildContext context) {
    return io.Platform.isIOS
        ? CupertinoButton(
            onPressed: handler,
            child: Text(
              text,
            ),
          )
        : TextButton(
            onPressed: handler,
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
