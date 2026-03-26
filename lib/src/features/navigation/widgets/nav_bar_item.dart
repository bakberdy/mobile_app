import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavBarItem {
  const NavBarItem({this.label, required this.icon});

  final String? label;
  final Widget icon;
}

class NavBarEntry extends StatefulWidget {
  const NavBarEntry({
    super.key,
    this.label,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
    this.width = 80,
  });

  final String? label;
  final Widget icon;
  final bool isSelected;
  final VoidCallback onTap;
  final double width;

  @override
  State<NavBarEntry> createState() => _NavBarEntryState();
}

class _NavBarEntryState extends State<NavBarEntry>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> _iconScale;
  late final AnimationController _tapController;
  late final Animation<double> _tapScale;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
      reverseDuration: const Duration(milliseconds: 160),
    );

    _iconScale = Tween<double>(begin: 1, end: 1.1)
        .chain(CurveTween(curve: Curves.easeOutCubic))
        .animate(animationController);

    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
      reverseDuration: const Duration(milliseconds: 140),
    );
    _tapScale = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_tapController);
    if (widget.isSelected) {
      animationController.value = 1;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NavBarEntry oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSelected != widget.isSelected) {
      if (widget.isSelected) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _tapController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomTheme = BottomNavigationBarTheme.of(context);
    final bool showLabel = widget.label != null
        ? widget.isSelected
              ? (bottomTheme.showSelectedLabels ?? true)
              : (bottomTheme.showUnselectedLabels ?? false)
        : false;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        _tapController.forward(from: 0);
      },
      onTapUp: (_) {
        _tapController.reverse();
        if (bottomTheme.enableFeedback == true) {
          HapticFeedback.lightImpact();
        }
        widget.onTap();
      },
      onTapCancel: () {
        _tapController.reverse();
      },
      child: IconTheme(
        data: widget.isSelected
            ? bottomTheme.selectedIconTheme ?? const IconThemeData()
            : bottomTheme.unselectedIconTheme ?? const IconThemeData(),
        child: Container(
          alignment: Alignment.center,
          width: widget.width,
          height: 60,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: Listenable.merge([
                  animationController,
                  _tapController,
                ]),
                builder: (context, child) {
                  final double scale = _iconScale.value * _tapScale.value;
                  return Transform.scale(scale: scale, child: child);
                },
                child: widget.icon,
              ),
              if (showLabel)
                AnimatedBuilder(
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _tapScale.value,
                      child: child,
                    );
                  },
                  animation: _tapController,
                  child: Text(
                      widget.label!,
                      style: widget.isSelected
                          ? bottomTheme.selectedLabelStyle
                          : bottomTheme.unselectedLabelStyle,
                    ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
