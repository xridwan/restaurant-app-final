import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_final/provider/preferences_provider.dart';
import 'package:restaurant_app_final/provider/scheduling_provider.dart';
import 'package:restaurant_app_final/widgets/custom_dialog.dart';
import 'package:restaurant_app_final/widgets/platform_widget.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';

  const SettingsPage({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(settingsTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      children: [
        Material(
          child: ListTile(
            title: const Text('Dark Theme'),
            trailing: Consumer<PreferencesProvider>(
              builder: (context, provider, child) {
                return Switch.adaptive(
                  value: provider.isDarkTheme,
                  onChanged: (value) {
                    provider.enableDarkTheme(value);
                  },
                );
              },
            ),
          ),
        ),
        Material(
          child: ListTile(
            title: const Text('Restaurant Notification'),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, provider, _) {
                return Switch.adaptive(
                  value: provider.isScheduled,
                  onChanged: (value) async {
                    if (Platform.isIOS) {
                      customDialog(context);
                    } else {
                      provider.scheduledRestaurant(value);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
