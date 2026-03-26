import 'package:flutter/material.dart';

class ScrollToTopProvider extends InheritedWidget {
  const ScrollToTopProvider({super.key, required super.child, required this.onScrollToTop, required this.onRegisterCallback});
  final VoidCallback onScrollToTop;
  final void Function(VoidCallback) onRegisterCallback;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static ScrollToTopProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ScrollToTopProvider>();
  }
}