import 'package:auto_route/auto_route.dart';
import 'package:travel_app/src/core/api/storage/token_storage.dart';
class AuthGuard extends AutoRouteGuard {
  final TokenStorage _tokenStorage;

  AuthGuard({required TokenStorage tokenStorage})
    : _tokenStorage = tokenStorage;
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final token =
        await _tokenStorage.getAccessToken();

    if (token != null && token.isNotEmpty) {
      resolver.next(true);
    } else {
      // router.replaceAll([const LoginRoute()]);
      resolver.next(true);
    }
  }
}
