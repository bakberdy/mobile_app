import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/src/features/navigation/providers/scroll_to_top_provider.dart';
import 'package:travel_app/src/features/navigation/widgets/nav_bar.dart';
import 'package:travel_app/src/features/navigation/widgets/nav_bar_item.dart';

@RoutePage()
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  // Store a callback to trigger scroll to top
  VoidCallback? _scrollToTopCallback;

  void _registerScrollToTop(VoidCallback callback) {
    _scrollToTopCallback = callback;
  }

  void _triggerScrollToTop() {
    _scrollToTopCallback?.call();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollToTopProvider(
      onScrollToTop: _triggerScrollToTop,
      onRegisterCallback: _registerScrollToTop,
      child: AutoTabsScaffold(
        extendBody: true,
        routes: [
          // (),
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
            NavBarItem(icon: const Icon(Icons.home, size: 20,), label: 'Home'),
            NavBarItem(icon: const Icon(Icons.person, size: 20,), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
