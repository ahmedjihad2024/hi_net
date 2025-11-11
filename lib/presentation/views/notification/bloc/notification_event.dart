part of 'notification_bloc.dart';

sealed class NotificationEvent {
  const NotificationEvent();
}

class GetNotificationEvent extends NotificationEvent {
  final bool isRefresh;
  final RefreshController refreshController;

  const GetNotificationEvent(
    {
      required this.isRefresh,
      required this.refreshController,
    
    }
  );
}

class SetNotificationAsReadedEevent extends NotificationEvent {
  final List<String> ids;

  SetNotificationAsReadedEevent({
    required this.ids,
  });
}
