import 'package:diresto/data/model/detail_restaurant.dart';

class TableRestaurant {
  final String id;
  final String pictureId;
  final String name;
  final String description;
  final String city;
  final double rating;

  TableRestaurant({
    required this.id,
    required this.pictureId,
    required this.name,
    required this.description,
    required this.city,
    required this.rating,
  });

  factory TableRestaurant.fromEntity(DetailRestaurantData restaurant) =>
      TableRestaurant(
        id: restaurant.id,
        pictureId: restaurant.pictureId,
        name: restaurant.name,
        description: restaurant.description,
        city: restaurant.city,
        rating: restaurant.rating,
      );

  factory TableRestaurant.fromMap(Map<String, dynamic> map) => TableRestaurant(
        id: map['id'],
        pictureId: map['pictureId'],
        name: map['name'],
        description: map['description'],
        city: map['city'],
        rating: map['rating'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'pictureId': pictureId,
        'name': name,
        'description': description,
        'city': city,
        'rating': rating,
      };
}
