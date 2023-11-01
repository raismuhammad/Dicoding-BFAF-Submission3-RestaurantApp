import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        final payload = details.payload;

        if (payload != null) debugPrint('notification payload: $payload');

        selectNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantResult restaurantResult) async {
    const channelId = '1';
    const channelName = 'channel_01';
    const channelDescription = 'restaurant app channel';

    const androidPlatformChannelSpesifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: DefaultStyleInformation(true, true),
    );

    const platformChannelSpesifics =
        NotificationDetails(android: androidPlatformChannelSpesifics);

    const titleNotification = "<b>Rekomendasi restaurant hari ini</b>";
    final randomIndex = Random().nextInt(restaurantResult.restaurants.length);
    final restaurant = restaurantResult.restaurants[randomIndex];
    debugPrint(json.encode(restaurant.toJson()));

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      restaurant.name,
      platformChannelSpesifics,
      payload: json.encode(restaurant.toJson()),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((payload) async {
      final data = Restaurant.fromJson(json.decode(payload));
      Navigation.intentWithData(route, data);
    });
  }
}
