import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_final/provider/database_provider.dart';
import 'package:restaurant_app_final/utils/result_state.dart';
import 'package:restaurant_app_final/widgets/response_widget.dart';
import 'package:restaurant_app_final/widgets/restaurant_item.dart';
import 'package:restaurant_app_final/widgets/platform_widget.dart';

class BookmarksPage extends StatelessWidget {
  static const String bookmarksTitle = 'Bookmarks';

  const BookmarksPage({Key? key}) : super(key: key);

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.bookmarks.length,
            itemBuilder: (context, index) {
              return RestaurantItem(
                restaurant: provider.bookmarks[index],
              );
            },
          );
        } else {
          return Center(
            child: emptyDataWidget(provider.message),
          );
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(bookmarksTitle),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(bookmarksTitle),
      ),
      child: _buildList(),
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
