import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_final/common/styles.dart';
import 'package:restaurant_app_final/ui/restaurant_list_page.dart';
import 'package:restaurant_app_final/ui/bookmarks_page.dart';
import 'package:restaurant_app_final/ui/restaurant_detail_page.dart';
import 'package:restaurant_app_final/ui/settings_page.dart';
import 'package:restaurant_app_final/utils/notification_helper.dart';
import 'package:restaurant_app_final/widgets/platform_widget.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  static const String _restaurantText = 'Restaurant';

  final NotificationHelper _notificationHelper = NotificationHelper();

  final List<Widget> _listWidget = [
    const ArticleListPage(),
    const BookmarksPage(),
    const SettingsPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.home : Icons.home),
      label: _restaurantText,
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Platform.isIOS ? CupertinoIcons.bookmark : Icons.collections_bookmark,
      ),
      label: BookmarksPage.bookmarksTitle,
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Platform.isIOS ? CupertinoIcons.settings : Icons.settings,
      ),
      label: SettingsPage.settingsTitle,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _bottomNavBarItems,
        activeColor: secondaryColor,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
