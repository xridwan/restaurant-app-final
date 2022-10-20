import 'dart:io';

import 'package:provider/provider.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app_final/common/navigation.dart';
import 'package:restaurant_app_final/data/db/database_helper.dart';
import 'package:restaurant_app_final/data/model/restaurant.dart';
import 'package:restaurant_app_final/data/preferences/preferences_helper.dart';
import 'package:restaurant_app_final/provider/database_provider.dart';
import 'package:restaurant_app_final/provider/preferences_provider.dart';
import 'package:restaurant_app_final/provider/scheduling_provider.dart';
import 'package:restaurant_app_final/ui/restaurant_detail_page.dart';
import 'package:restaurant_app_final/ui/restaurant_search_page.dart';
import 'package:restaurant_app_final/ui/splash_screen.dart';
import 'package:restaurant_app_final/utils/background_service.dart';
import 'package:restaurant_app_final/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/home_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(
            preferencesHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance()),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Restaurant App',
            theme: provider.themeData,
            builder: (context, child) {
              return CupertinoTheme(
                data: CupertinoThemeData(
                  brightness:
                      provider.isDarkTheme ? Brightness.dark : Brightness.light,
                ),
                child: Material(
                  child: child,
                ),
              );
            },
            navigatorKey: navigatorKey,
            initialRoute: SplashScreenPage.routeName,
            routes: {
              SplashScreenPage.routeName: (context) => const SplashScreenPage(),
              HomePage.routeName: (context) => const HomePage(),
              RestaurantSearchPage.routeName: (context) =>
                  const RestaurantSearchPage(),
              RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                  restaurant:
                      ModalRoute.of(context)?.settings.arguments as Restaurant),
            },
          );
        },
      ),
    );
  }
}
//