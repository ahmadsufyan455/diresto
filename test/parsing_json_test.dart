import 'package:diresto/data/model/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';

const restaurantJson = {
  'id': 'rqdv5juczeskfw1e867',
  'name': 'Melting Pot',
  'description':
      'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.',
  'pictureId': '14',
  'city': 'Medan',
  'rating': 4.2,
};

void main() {
  test("parsing json test", () async {
    final result = Restaurant.fromJson(restaurantJson);
    const expectedResult = Restaurant(
      id: 'rqdv5juczeskfw1e867',
      name: 'Melting Pot',
      description:
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.',
      pictureId: '14',
      city: 'Medan',
      rating: 4.2,
    );
    expect(result, expectedResult);
  });
}
