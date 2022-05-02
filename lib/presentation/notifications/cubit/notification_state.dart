part of 'notification_cubit.dart';

@immutable
class NotificationState {
  final String? message;

  const NotificationState(this.message);

  NotificationState copyWith({String? message}) {
    return NotificationState(
      message ?? this.message,
    );
  }
}
