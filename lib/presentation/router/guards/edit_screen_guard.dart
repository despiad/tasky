import 'package:auto_route/auto_route.dart';

class EditScreenGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (resolver.route.args != null) {
      resolver.next(true);
    }
  }
}
