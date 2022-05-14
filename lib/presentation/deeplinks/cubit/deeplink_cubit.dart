import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/router/app_router.gr.dart';
import 'package:uni_links/uni_links.dart';

part 'deeplink_state.dart';

class DeeplinkCubit extends Cubit<DeeplinkState> {
  final AppRouter _appRouter;
  late StreamSubscription _subscription;

  DeeplinkCubit(this._appRouter) : super(DeeplinkInitial());

  Future<void> initLinks() async {
    try {
      final initialUri = await getInitialUri();
      if (initialUri != null) {
        emit(DeeplinkSuccess(initialUri.path));
        _appRouter.navigateNamed(initialUri.path, includePrefixMatches: true);
      }
      _subscription = uriLinkStream.listen((uri) {
        if (uri != null) {
          emit(DeeplinkSuccess(uri.path));
          _appRouter.navigateNamed(uri.path, includePrefixMatches: true);
        }
      });
    } catch (e) {
      emit(DeeplinkError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
