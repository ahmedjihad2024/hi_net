import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:hi_net/app/dependency_injection.dart';
import 'package:hi_net/app/user_messages.dart';
import 'package:hi_net/data/network/error_handler/failure.dart';
import 'package:hi_net/data/request/request.dart';
import 'package:hi_net/data/responses/responses.dart';
import 'package:hi_net/presentation/common/utils/state_render.dart';
import 'package:equatable/equatable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationState()) {
  }
}
