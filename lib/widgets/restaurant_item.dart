import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_final/common/navigation.dart';
import 'package:restaurant_app_final/common/styles.dart';
import 'package:restaurant_app_final/data/model/restaurant.dart';
import 'package:restaurant_app_final/provider/database_provider.dart';
import 'package:restaurant_app_final/ui/restaurant_detail_page.dart';
import 'package:restaurant_app_final/widgets/response_widget.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantItem({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(restaurant.name),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () {
                  Navigation.intentWithData(
                    RestaurantDetailPage.routeName,
                    restaurant,
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Hero(
                        tag: restaurant.id,
                        child: Container(
                          width: 70,
                          height: 70,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                restaurant.getSmallPicture(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant.name,
                              style: blackTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: medium,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              restaurant.city,
                              style: greyTextStyle.copyWith(
                                fontWeight: light,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          getBookmarked(
                              context, isBookmarked, provider, restaurant),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
