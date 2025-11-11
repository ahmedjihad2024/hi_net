part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final ReqState reqState;
  final String errorMessage;

  const NotificationState({
    this.reqState = ReqState.loading,
    this.errorMessage = '',
  });

  NotificationState copyWith({
    ReqState? reqState,
    String? errorMessage,
  }) {
    return NotificationState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        reqState,
        errorMessage,
      ];
}
