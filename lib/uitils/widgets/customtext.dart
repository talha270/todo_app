import 'dart:ui';
import 'package:flutter/material.dart';

customtext({
  required String text,
  double size = 12.0,
  Color color = Colors.black,
  FontWeight wiegth = FontWeight.normal,
  TextOverflow overflow = TextOverflow.ellipsis, // Allow overflow customization
  int maxLines = 1, // Limit to a single line by default
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      color: color,
      fontWeight: wiegth,
      fontFamily: "style"
    ),
    overflow: overflow,
    maxLines: 1,
  );
}
