import 'dart:convert';
import 'dart:math';

import 'package:diresto/data/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;
  final _random = Random();

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) async {
      final payload = details.payload;
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Restaurants restaurantData) async {
    var channelId = '1';
    var channelName = 'channel_01';
    var channelDescription = 'Diresto channel';

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var restaurants = restaurantData.restaurants;
    var randomRestaurant = _random.nextInt(restaurants.length);
    var restaurantName = restaurantData.restaurants[randomRestaurant].name;

    await flutterLocalNotificationsPlugin.show(
      0,
      restaurantName,
      'Recommendation restaurant for you!',
      platformChannelSpecifics,
      payload: jsonEncode(restaurantData.restaurants[randomRestaurant]),
    );
  }

  void configureSelectNotificationSubject(
      BuildContext context, String routeName) {
    selectNotificationSubject.stream.listen((payload) async {
      var data = Restaurant.fromJson(jsonDecode(payload));
      Navigator.pushNamed(context, routeName, arguments: data.id);
    });
  }
}
