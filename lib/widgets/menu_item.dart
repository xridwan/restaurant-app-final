import 'package:flutter/material.dart';
import 'package:restaurant_app_final/common/styles.dart';

Widget menuItem(String name) {
  return Card(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    color: kPrimaryColor,
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 14,
      ),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: whiteTextStyle.copyWith(
            fontWeight: medium,
          ),
        ),
      ),
    ),
  );
}
