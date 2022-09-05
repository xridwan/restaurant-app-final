import 'package:flutter/material.dart';
import 'package:restaurant_app_final/common/styles.dart';
import 'package:restaurant_app_final/provider/restaurant_provider.dart';

class BoxSearch extends StatelessWidget {
  final RestaurantProvider provider;

  const BoxSearch({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (() => Navigator.pop(context)),
            child: Container(
              margin: const EdgeInsets.only(right: 16),
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
          Expanded(
            child: TextFormField(
              onChanged: (value) {
                if (value.isNotEmpty) {
                  provider.onSearch(value);
                } else if (value.isEmpty) {
                  provider.onSearch(" ");
                }
              },
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
                letterSpacing: 1.2,
              ),
              decoration: InputDecoration(
                hintText: 'Search Restaurant...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
