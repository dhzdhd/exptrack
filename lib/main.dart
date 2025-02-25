import 'dart:async';
import 'dart:ui';

import 'package:exptrack/log.dart';
import 'package:exptrack/src/home/repositories/auto_expense_repo.dart';
import 'package:exptrack/src/home/repositories/subscription_repo.dart';
import 'package:exptrack/src/home/repositories/transaction_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notification_listener_service/notification_listener_service.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initService();

  await Hive.initFlutter();
  await SubscriptionRepository.init();
  await TransactionRepository.init();
  await AutoExpenseRepository.init();

  FlutterLocalNotificationsPlugin notifs = FlutterLocalNotificationsPlugin();
  await notifs
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
  await notifs
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestExactAlarmsPermission();

  if (!(await NotificationListenerService.isPermissionGranted())) {
    await NotificationListenerService.requestPermission();
  }
  NotificationListenerService.notificationsStream.listen((event) {
    debugLogger.d("Current notification: $event");
  });

  runApp(const ProviderScope(child: MyApp()));
}

const notificationChannelId = 'foreground';
const notificationId = 888;

Future<void> initService() async {
  final service = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId,
    'EXPTRACK FOREGROUND SERVICE',
    description: 'This channel is used for important notifications.',
    importance: Importance.low,
  );

  final FlutterLocalNotificationsPlugin notifs =
      FlutterLocalNotificationsPlugin();

  await notifs
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      autoStartOnBoot: true,
      isForegroundMode: true,
      notificationChannelId: notificationChannelId,
      initialNotificationTitle: 'ExpTrack',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: notificationId,
    ),
  );
}

@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  final FlutterLocalNotificationsPlugin notifs =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    if (await service.isForegroundService()) {
      await notifs.show(
        notificationId,
        'ExpTrack',
        'Dummy message. Please ignore.',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            notificationChannelId,
            'EXPTRACK FOREGROUND SERVICE',
            icon: 'ic_bg_service_small',
            ongoing: true,
          ),
        ),
      );
    }
  }
}
