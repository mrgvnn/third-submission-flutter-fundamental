import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:firstffasubmission/provider/favorite_restaurant_provider.dart';
import 'package:firstffasubmission/provider/preferences_provider.dart';
import 'package:firstffasubmission/provider/scheduling_provider.dart';
import 'package:firstffasubmission/ui/detail_screen.dart';
import 'package:firstffasubmission/ui/favorite_screen.dart';
import 'package:firstffasubmission/ui/home_screen.dart';
import 'package:firstffasubmission/ui/search_screen.dart';
import 'package:firstffasubmission/ui/setting_screen.dart';
import 'package:firstffasubmission/utility/background_service.dart';
import 'package:firstffasubmission/utility/notification_helper.dart';
import 'package:firstffasubmission/utility/preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/database/db_helper.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantFavoriteProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Restaurant Api',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          SearchBar.routeName: (context) => const SearchBar(),
          FavoriteScreen.routeName: (contex) => const FavoriteScreen(),
          SettingScreen.routeName: (context) => const SettingScreen(),
          DetailScreen.routeName: (context) => DetailScreen(id: ModalRoute.of(context).settings.arguments as String),
        },
      ),
    );
  }
}
