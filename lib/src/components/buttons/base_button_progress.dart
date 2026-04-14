import 'package:flutter/material.dart';

Widget baseButtonProgressIndicator(Color color) {
  return SizedBox(
    width: 20,
    height: 20,
    child: CircularProgressIndicator(strokeWidth: 2, color: color),
  );
}
