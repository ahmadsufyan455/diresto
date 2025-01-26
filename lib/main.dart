import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:diresto/injection.dart' as di;
import 'package:diresto/presentation/detail/bloc/add_review_bloc.dart';
import 'package:diresto/presentation/detail/bloc/detail_restaurant_bloc.dart';
import 'package:diresto/presentation/detail/bloc/favorite_bloc.dart';
import 'package:diresto/presentation/detail/detail_restaurant_screen.dart';
import 'package:diresto/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:diresto/presentation/favorite/favorite_screen.dart';
import 'package:diresto/presentation/home/home_screen.dart';
import 'package:diresto/presentation/list/bloc/restaurants_bloc.dart';
import 'package:diresto/presentation/list/list_restaurant_screen.dart.dart';
import 'package:diresto/presentation/search/bloc/search_bloc.dart';
import 'package:diresto/presentation/search/search_screen.dart';
import 'package:diresto/presentation/settings/cubit/settings_cubit.dart';
import 'package:diresto/presentation/settings/settings_screen.dart';
import 'package:diresto/presentation/splash/splash_screen.dart';
import 'package:diresto/theme/theme.dart';
import 'package:diresto/utils/background_service.dart';
import 'package:diresto/utils/notification_helper.dart';
import 'package:diresto/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.locator<RestaurantsBloc>()),
        BlocProvider(create: (context) => di.locator<DetailRestaurantBloc>()),
        BlocProvider(create: (context) => di.locator<SearchBloc>()),
        BlocProvider(create: (context) => di.locator<AddReviewBloc>()),
        BlocProvider(create: (context) => di.locator<FavoriteBloc>()),
        BlocProvider(create: (context) => di.locator<FavoriteCubit>()),
        BlocProvider(create: (context) => di.locator<SettingsCubit>()),
      ],
      child: BlocBuilder<SettingsCubit, Map<String, bool>>(
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Diresto App',
          theme: (state['isDarkMode'] ?? false) ? darkMode : lightMode,
          home: const SplashScreen(),
          navigatorObservers: [routeObserver],
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case HomeScreen.routeName:
                return MaterialPageRoute(builder: (_) => const HomeScreen());
              case ListRestaurantScreen.routeName:
                return MaterialPageRoute(
                    builder: (_) => const ListRestaurantScreen());
              case DetailRestaurantScreen.routeName:
                final id = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (_) => DetailRestaurantScreen(id: id),
                  settings: settings,
                );
              case SearchScreen.routeName:
                return MaterialPageRoute(builder: (_) => const SearchScreen());
              case SettingsScreen.routeName:
                return MaterialPageRoute(
                    builder: (_) => const SettingsScreen());
              case FavoriteScreen.routeName:
                return MaterialPageRoute(
                    builder: (_) => const FavoriteScreen());
              default:
                return MaterialPageRoute(builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                });
            }
          },
        ),
      ),
    );
  }
}
