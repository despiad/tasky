part of 'deeplink_cubit.dart';

@immutable
abstract class DeeplinkState {}

class DeeplinkInitial extends DeeplinkState {}

class DeeplinkSuccess extends DeeplinkState {
  final String parsedPath;

  DeeplinkSuccess(this.parsedPath);
}

class DeeplinkError extends DeeplinkState {
  final String errorMessage;

  DeeplinkError(this.errorMessage);
}
