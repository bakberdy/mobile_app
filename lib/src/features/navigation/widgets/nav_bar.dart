import 'package:flutter/material.dart';
import 'package:mobile_app/src/core/utils/extensions/context_x.dart';
import 'package:mobile_app/src/features/navigation/widgets/nav_bar_item.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
    required this.initialPage,
    required this.onPageChanged,
    required this.items,
    this.isSliding = true,
    this.itemWidth = 80,
    this.sliderColor,
  }) : assert(itemWidth > 0, 'itemWidth must be greater than zero'),
       assert(items.length > 0, 'items must not be empty'),
       assert(
         initialPage >= 0 && initialPage < items.length,
         'initialPage must be within items bounds',
       );

  final int initialPage;
  final ValueChanged<int> onPageChanged;
  final List<NavBarItem> items;
  final bool isSliding;
  final double itemWidth;
  final Color? sliderColor;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late int _currentPage;
  double? _dragLeft;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
  }

  @override
  void didUpdateWidget(covariant NavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialPage != widget.initialPage) {
      _currentPage = widget.initialPage;
    }
  }

  @override
  Widget build(BuildContext context) {
    const spacing = 10.0;
    final totalWidth =
        widget.items.length * widget.itemWidth +
        (widget.items.length - 1) * spacing;
    final slotWidth = widget.itemWidth + spacing;
    final indicatorLeft = _dragLeft ?? _currentPage * slotWidth;
    final indicatorRight = totalWidth - indicatorLeft - widget.itemWidth;
    final isLtr = context.isRTL;
    final theme = Theme.of(context);
    final sliderColor =
        widget.sliderColor ?? theme.colorScheme.surfaceContainer;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: theme.bottomNavigationBarTheme.backgroundColor,
              borderRadius: BorderRadius.circular(59),
              boxShadow: [
                BoxShadow(color: Colors.grey.withAlpha(200), blurRadius: 5),
              ],
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onHorizontalDragStart: (_) {
                setState(() => _dragLeft = _currentPage * slotWidth);
              },
              onHorizontalDragUpdate: (details) {
                final center = details.localPosition.dx;
                final clampedCenter = center.clamp(
                  widget.itemWidth / 2,
                  totalWidth - widget.itemWidth / 2,
                );
                setState(
                  () => _dragLeft = clampedCenter - widget.itemWidth / 2,
                );
              },
              onHorizontalDragEnd: (_) {
                final left = _dragLeft ?? _currentPage * slotWidth;
                final center = left + widget.itemWidth / 2;
                final snapped = (center / slotWidth).floor().clamp(
                  0,
                  widget.items.length - 1,
                );
                setState(() {
                  _currentPage = snapped;
                  _dragLeft = null;
                });
                widget.onPageChanged(_currentPage);
              },
              onHorizontalDragCancel: () => setState(() => _dragLeft = null),
              child: SizedBox(
                width: totalWidth,
                child: Stack(
                  children: [
                    if (widget.isSliding)
                      (_dragLeft != null)
                          ? Positioned(
                              left: isLtr ? indicatorLeft : null,
                              right: isLtr ? null : indicatorRight,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                width: widget.itemWidth,
                                decoration: BoxDecoration(
                                  color: sliderColor,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                            )
                          : AnimatedPositioned(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOutCubic,
                              left: isLtr ? indicatorLeft : null,
                              right: isLtr ? null : indicatorRight,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                width: widget.itemWidth,
                                decoration: BoxDecoration(
                                  color: sliderColor,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                            ),
                    Row(
                      spacing: spacing,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: widget.items
                          .map(
                            (e) => NavBarEntry(
                              icon: e.icon,
                              width: widget.itemWidth,
                              onTap: () {
                                final int newPage = widget.items.indexOf(e);
                                if (_currentPage != newPage) {
                                  setState(() => _currentPage = newPage);
                                }
                                widget.onPageChanged(newPage);
                              },
                              isSelected:
                                  _currentPage == widget.items.indexOf(e),
                              label: e.label,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
