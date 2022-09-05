import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_final/common/navigation.dart';
import 'package:restaurant_app_final/common/styles.dart';
import 'package:restaurant_app_final/data/api/api_service.dart';
import 'package:restaurant_app_final/provider/restaurant_provider.dart';
import 'package:restaurant_app_final/ui/restaurant_search_page.dart';
import 'package:restaurant_app_final/utils/result_state.dart';
import 'package:restaurant_app_final/widgets/response_widget.dart';
import 'package:restaurant_app_final/widgets/restaurant_item.dart';
import 'package:restaurant_app_final/widgets/platform_widget.dart';

class ArticleListPage extends StatelessWidget {
  const ArticleListPage({Key? key}) : super(key: key);

  Widget _buildList() {
    return ChangeNotifierProvider(
      create: (_) =>
          RestaurantProvider(apiService: ApiService()).getRestaurants(),
      builder: (context, child) {
        return Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              );
            } else if (state.state == ResultState.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.result.restaurants.length,
                itemBuilder: (context, index) {
                  var article = state.result.restaurants[index];
                  return RestaurantItem(restaurant: article);
                },
              );
            } else if (state.state == ResultState.error) {
              return noInternetWidget(state.message);
            } else {
              return emptyDataWidget(state.message);
            }
          },
        );
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigation.intentNoData(RestaurantSearchPage.routeName);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Restaurant App'),
        transitionBetweenRoutes: false,
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
