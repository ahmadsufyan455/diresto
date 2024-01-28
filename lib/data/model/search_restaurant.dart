class SearchRestaurants {
  final int founded;
  final List<SearchRestaurant> restaurants;
  SearchRestaurants({required this.founded, required this.restaurants});

  factory SearchRestaurants.fromJson(Map<String, dynamic> json) =>
      SearchRestaurants(
        founded: json['founded'],
        restaurants: List.from((json['restaurants'] as List)
            .map((restaurant) => SearchRestaurant.fromJson(restaurant))
            .toList()),
      );
}

class SearchRestaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  SearchRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory SearchRestaurant.fromJson(Map<String, dynamic> json) =>
      SearchRestaurant(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        rating: json['rating'] * 1.0,
      );
}
