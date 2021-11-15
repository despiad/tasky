part of 'notification_cubit.dart';

@immutable
class NotificationState {
  final String? message;
  final bool isPermitted;

  const NotificationState(this.message, this.isPermitted);

  NotificationState copyWith({String? message, bool? isPermitted}) {
    return NotificationState(
      message ?? this.message,
      isPermitted ?? this.isPermitted,
    );
  }
}
