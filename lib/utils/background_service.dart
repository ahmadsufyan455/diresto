import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:diresto/data/datasource/db/database_helper.dart';
import 'package:diresto/data/datasource/local_datasource.dart';
import 'package:diresto/data/datasource/remote_datasource.dart';
import 'package:diresto/data/repositories/app_repository_impl.dart';
import 'package:diresto/domain/repositories/app_repository.dart';
import 'package:diresto/domain/usecase/get_restaurants.dart';
import 'package:diresto/main.dart';
import 'package:diresto/utils/constants.dart';
import 'package:diresto/utils/notification_helper.dart';
import 'package:flutter/material.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationHelper notificationHelper = NotificationHelper();
    final RemoteDatasource remoteDatasource =
        RemoteDatasourceImpl(dio: Dio(BaseOptions(baseUrl: baseURL)));
    final LocalDatasource localDatasource =
        LocalDatasourceImpl(databaseHelper: DatabaseHelper());
    final AppRepository appRepository = AppRepositoryImpl(
        remoteDatasource: remoteDatasource, localDatasource: localDatasource);
    final GetRestaurants getRestaurants =
        GetRestaurants(appRepository: appRepository);
    final result = await getRestaurants.execute();
    result.fold(
      (failure) => debugPrint(failure.message),
      (data) async {
        await notificationHelper.showNotification(
            flutterLocalNotificationsPlugin, data);
      },
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
