import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app_final/data/model/restaurant.dart';

void main() {
  var restaurant = Restaurant(
    id: "abc123",
    name: "Restaurant",
    description: "Test 123",
    pictureId: "1",
    city: "Bandung",
  );

  test('Should success parsing json', () {
    var result = Restaurant.fromJson(restaurant.toJson());

    expect(result.name, restaurant.name);
  });
}
