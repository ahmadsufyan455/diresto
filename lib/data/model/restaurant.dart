import 'package:equatable/equatable.dart';

class Restaurants {
  final List<Restaurant> restaurants;
  Restaurants({required this.restaurants});

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        restaurants: List.from((json['restaurants'] as List)
            .map((restaurant) => Restaurant.fromJson(restaurant))
            .toList()),
      );

  Map<String, dynamic> toJson() => {
        'restaurants': List<dynamic>.from(
            restaurants.map((restaurant) => restaurant.toJson()))
      };
}

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        rating: json['rating'] * 1.0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'pictureId': pictureId,
        'city': city,
        'rating': rating,
      };

  @override
  List<Object?> get props => [id, name, description, pictureId, city, rating];
}
