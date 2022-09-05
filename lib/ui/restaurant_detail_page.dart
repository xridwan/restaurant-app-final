import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_final/common/styles.dart';
import 'package:restaurant_app_final/data/api/api_service.dart';
import 'package:restaurant_app_final/data/model/restaurant.dart';
import 'package:restaurant_app_final/provider/database_provider.dart';
import 'package:restaurant_app_final/provider/restaurant_provider.dart';
import 'package:restaurant_app_final/utils/result_state.dart';
import 'package:restaurant_app_final/widgets/menu_item.dart';
import 'package:restaurant_app_final/widgets/response_widget.dart';

import '../data/model/restaurant_detail.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) {
        RestaurantProvider provider =
            RestaurantProvider(apiService: ApiService());
        return provider.getRestaurant(restaurant.id);
      },
      child: Scaffold(
        body: Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              );
            } else if (state.state == ResultState.hasData) {
              return detailScreen(
                context,
                state.detail.restaurant,
                restaurant,
              );
            } else if (state.state == ResultState.error) {
              return noInternetWidget(state.message);
            } else {
              return emptyDataWidget(state.message);
            }
          },
        ),
      ),
    );
  }

  detailScreen(
      BuildContext context, RestaurantD restaurantD, Restaurant restaurant) {
    return Consumer<DatabaseProvider>(
      builder: (context, value, child) {
        return FutureBuilder<bool>(
          future: value.isBookmarked(restaurant.name),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: restaurant.id,
                        child: Image.network(restaurant.getMediumPicture()),
                      ),
                      SafeArea(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (() => Navigator.pop(context)),
                              child: Container(
                                margin: const EdgeInsets.only(
                                  left: 16,
                                  top: 16,
                                ),
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: kPrimaryColor,
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: kWhiteColor,
                                ),
                              ),
                            ),
                            getBookmarked(
                                context, isBookmarked, value, restaurant)
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              restaurant.name,
                              style: blackTextStyle.copyWith(
                                fontSize: 24,
                                letterSpacing: 1.5,
                                fontWeight: semiBold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  margin: const EdgeInsets.only(right: 4),
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/icon_star.png',
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  restaurantD.rating.toString(),
                                  style: blackTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: semiBold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: kGreyColor,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                restaurant.city,
                                style: greyTextStyle.copyWith(
                                  fontWeight: medium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 16,
                            bottom: 10,
                          ),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Description',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              letterSpacing: 1.5,
                              fontWeight: semiBold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            restaurant.description,
                            textAlign: TextAlign.justify,
                            style: blackTextStyle.copyWith(
                              height: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Menu',
                                style: blackTextStyle.copyWith(
                                  fontSize: 16,
                                  letterSpacing: 1.5,
                                  fontWeight: semiBold,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Foods :',
                                style: blackTextStyle.copyWith(
                                  fontSize: 12,
                                  letterSpacing: 1.5,
                                  fontWeight: medium,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: (MediaQuery.of(context).size.height * 0.06),
                          width: (MediaQuery.of(context).size.width * 0.94),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: restaurantD.menus.foods
                                .map((foods) => menuItem(foods.name))
                                .toList(),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Drinks :',
                                style: blackTextStyle.copyWith(
                                  fontSize: 12,
                                  letterSpacing: 1.5,
                                  fontWeight: medium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: (MediaQuery.of(context).size.height * 0.06),
                          width: (MediaQuery.of(context).size.width * 0.94),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: restaurantD.menus.drinks
                                .map((drinks) => menuItem(drinks.name))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
