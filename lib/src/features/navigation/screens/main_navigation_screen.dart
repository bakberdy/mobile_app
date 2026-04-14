import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/src/features/navigation/providers/scroll_to_top_provider.dart';
import 'package:mobile_app/src/features/navigation/widgets/nav_bar.dart';
import 'package:mobile_app/src/features/navigation/widgets/nav_bar_item.dart';

@RoutePage()
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  VoidCallback? _scrollToTopCallback;

  void _registerScrollToTop(VoidCallback callback) {
    _scrollToTopCallback = callback;
  }

  void _triggerScrollToTop() {
    _scrollToTopCallback?.call();
  }

  @override
  Widget build(BuildContext context) => ScrollToTopProvider(
    onScrollToTop: _triggerScrollToTop,
    onRegisterCallback: _registerScrollToTop,
    child: AutoTabsScaffold(
      extendBody: true,
      routes: const [
        // HomeRoute(),
        // OnboardingRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) => NavBar(
        initialPage: tabsRouter.activeIndex,
        onPageChanged: (int value) {
          if (value != tabsRouter.activeIndex) {
            tabsRouter.setActiveIndex(value);
          } else {
            _triggerScrollToTop();
          }
        },
        items: [
          const NavBarItem(icon: Icon(Icons.home, size: 20), label: 'Home'),
          const NavBarItem(
            icon: Icon(Icons.person, size: 20),
            label: 'Profile',
          ),
        ],
      ),
    ),
  );
}
