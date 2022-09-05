import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_app_final/common/styles.dart';
import 'package:restaurant_app_final/data/model/restaurant.dart';
import 'package:restaurant_app_final/provider/database_provider.dart';

Widget noInternetWidget(String message) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Lottie.asset(
        'assets/no_internet.json',
        width: 250,
        height: 250,
      ),
      const SizedBox(height: 8),
      Text(message,
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
          textAlign: TextAlign.center),
    ],
  );
}

Widget emptyDataWidget(String message) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Lottie.asset(
        'assets/empty_data.json',
        width: 250,
        height: 250,
      ),
      const SizedBox(height: 8),
      Text(message,
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
          textAlign: TextAlign.center),
    ],
  );
}

Widget getBookmarked(BuildContext context, bool fav, DatabaseProvider provider,
    Restaurant restaurant) {
  if (fav) {
    return IconButton(
      icon: const Icon(Icons.bookmark),
      color: Colors.redAccent,
      onPressed: () => provider.removeBookmark(restaurant.name),
    );
  } else {
    return IconButton(
      icon: const Icon(Icons.bookmark_border),
      color: Colors.redAccent,
      onPressed: () => provider.addBookmark(restaurant),
    );
  }
}
