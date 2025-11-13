import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/animations/animations_enum.dart';
import 'package:hi_net/presentation/common/ui_components/circular_progress_indicator.dart';
import 'package:hi_net/presentation/common/ui_components/customized_smart_refresh.dart';
import 'package:hi_net/presentation/common/ui_components/default_app_bar.dart';
import 'package:hi_net/presentation/common/ui_components/error_widget.dart';
import 'package:hi_net/presentation/common/utils/after_layout.dart';
import 'package:hi_net/presentation/common/utils/state_render.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';
import 'package:hi_net/presentation/views/notification/bloc/notification_bloc.dart';
import 'package:hi_net/presentation/views/notification/screens/widget/notification_card.dart';
import 'package:hi_net/presentation/common/ui_components/platform_safe_area.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> with AfterLayout {
  final RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                children: [
                  49.verticalSpace,
                  DefaultAppBar(
                    actionButtons: [
                      Expanded(
                        child: Row(
                          spacing: 14.w,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Translation.notifications.tr,
                              style: context.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 40.w),
                    ],
                  ).animatedOnAppear(0, SlideDirection.down),
                  14.verticalSpace,
                  ScreenState.setState(
                    reqState: ReqState.success,
                    loading: () {
                      return Expanded(
                        child: const Center(
                          child: MyCircularProgressIndicator(),
                        ).animatedOnAppear(0, SlideDirection.up),
                      );
                    },
                    error: () {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeM.pagePadding.dg,
                          ),
                          child: MyErrorWidget(
                            onRetry: () {
                              context.read<NotificationBloc>().add(
                                GetNotificationEvent(
                                  isRefresh: true,
                                  refreshController: refreshController,
                                ),
                              );
                            },
                            errorMessage: state.errorMessage,
                          ),
                        ).animatedOnAppear(0, SlideDirection.up),
                      );
                    },
                    empty: () {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeM.pagePadding.dg,
                          ),
                          child: MyErrorWidget(
                            onRetry: () {
                              context.read<NotificationBloc>().add(
                                GetNotificationEvent(
                                  isRefresh: true,
                                  refreshController: refreshController,
                                ),
                              );
                            },
                            errorMessage: "No notifications",
                          ),
                        ).animatedOnAppear(0, SlideDirection.up),
                      );
                    },
                    online: () {
                      return Expanded(
                        child: _NotificationList(
                          refreshController: refreshController,
                          notifications: [],
                        ).animatedOnAppear(0, SlideDirection.up),
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Future<void> afterLayout(BuildContext context) async {
    context.read<NotificationBloc>().add(
      GetNotificationEvent(
        isRefresh: true,
        refreshController: refreshController,
      ),
    );
  }
}

class _NotificationList extends StatelessWidget {
  final RefreshController refreshController;
  final List<dynamic> notifications;
  const _NotificationList({
    required this.refreshController,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return CustomizedSmartRefresh(
      enableLoading: true,
      controller: refreshController,
      onLoading: () {
        context.read<NotificationBloc>().add(
          GetNotificationEvent(
            isRefresh: false,
            refreshController: refreshController,
          ),
        );
      },
      onRefresh: () {
        context.read<NotificationBloc>().add(
          GetNotificationEvent(
            isRefresh: true,
            refreshController: refreshController,
          ),
        );
      },
      child: ListView.separated(
        padding:
            EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg) +
            EdgeInsets.only(
              top: 15.w,
              bottom:
                  SizeM.pagePadding.dg +
                  MediaQuery.viewPaddingOf(context).bottom,
            ),
        itemBuilder: (context, index) => NotificationCard(
          isNew: index % 2 == 0,
          title: "Notification Title",
          message: "Enjoy 20% off all international eSIM plans this week only",
          createdAt: DateTime.now(),
        ),
        separatorBuilder: (context, index) => 16.verticalSpace,
        itemCount: 20,
      ),
    );
  }
}
