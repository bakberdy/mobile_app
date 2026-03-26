import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/src/features/navigation/pages/main_navigation_page.dart';
import 'package:mobile_app/src/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:mobile_app/src/features/routes/domain/entities/route_category_entity.dart';
import 'package:mobile_app/src/features/routes/domain/entities/route_type_entity.dart';
import 'package:mobile_app/src/features/routes/presentation/pages/routes_page.dart';
import 'package:mobile_app/src/features/routes/presentation/pages/home_page.dart';
import 'package:mobile_app/src/features/user_config/presentation/screens/user_config_example_page.dart';
import 'auth_guard.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  final AuthGuard _authGuard;

  AppRouter({required AuthGuard authGuard}) : _authGuard = authGuard;

  @override
  List<AutoRoute> get routes => [
    // AutoRoute(page: UserConfigExampleScreen.page, initial: true),

    // AutoRoute(
    //   initial: false,
    //   page: MainNavigationRoute.page,

    //   guards: [_authGuard],
    //   children: [
    //     AutoRoute(page: OnboardingRoute.page),
    //     AutoRoute(page: HomeRoute.page, path: 'home', initial: true),
    //     // AutoRoute(page: CatalogRoute.page, path: 'catalog'),
    //     // AutoRoute(page: CartRoute.page, path: 'cart'),
    //     // AutoRoute(page: ProfileRoute.page, path: 'profile'),
    //   ],
    // ),
    // // AutoRoute(page: CatalogItemDetailRoute.page, path: '/catalog/item/:itemId'),
  ];
}
