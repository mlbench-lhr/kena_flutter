import 'package:flutter/material.dart';
import 'package:kena/app/utils/service_error_handler.dart';
import 'package:kena/model/general/notification_model.dart';

import 'package:kena/repository/user_home_repo.dart';

class NotificationsService {
  static const String tag = '[AuthService]';
  final UserHomeRepository _userHomeRepo = UserHomeRepository();

  ///
  ///Get Notifications
  ///
  Future<List<NotificationModel>> getNotifications({
    required BuildContext context,
  }) async {
    try {
      final response = await _userHomeRepo.getNotifications();

      debugPrint("🔔 Notifications Response $response");

      final notifications = (response['notifications'] as List)
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return notifications;
    } catch (e) {
      if (context.mounted) {
        ErrorHandler.handle(context, e, serviceName: tag);
      }
      return [];
    }
  }
}
