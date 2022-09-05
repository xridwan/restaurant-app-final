import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_final/data/preferences/preferences_helper.dart';
import 'package:restaurant_app_final/utils/background_service.dart';
import 'package:restaurant_app_final/utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  SchedulingProvider({required this.preferencesHelper}) {
    _getDailyNotifyPreferences();
  }

  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling Restaurant Activated');
      preferencesHelper.setDailyNotify(_isScheduled);
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling Restaurant Canceled');
      preferencesHelper.setDailyNotify(_isScheduled);
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }

  void _getDailyNotifyPreferences() async {
    _isScheduled = await preferencesHelper.isDailyActive;
    notifyListeners();
  }
}
