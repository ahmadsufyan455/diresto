class DetailRestaurant {
  final DetailRestaurantData detailRestaurantData;
  DetailRestaurant({required this.detailRestaurantData});

  factory DetailRestaurant.fromJson(Map<String, dynamic> json) =>
      DetailRestaurant(
        detailRestaurantData: DetailRestaurantData.fromJson(json['restaurant']),
      );
}

class DetailRestaurantData {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String address;
  final double rating;
  final Menu menu;
  final List<Category> categories;
  final List<CustomerReviews> customerReviews;

  DetailRestaurantData({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.address,
    required this.rating,
    required this.menu,
    required this.categories,
    required this.customerReviews,
  });

  factory DetailRestaurantData.fromJson(Map<String, dynamic> json) =>
      DetailRestaurantData(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        address: json['address'],
        rating: json['rating'] * 1.0,
        menu: Menu.fromJson(json['menus']),
        categories: List.from(
          (json['categories'] as List)
              .map((category) => Category.fromJson(category))
              .toList(),
        ),
        customerReviews: List.from(
          (json['customerReviews'] as List)
              .map((review) => CustomerReviews.fromJson(review))
              .toList(),
        ),
      );
}

class Menu {
  final List<Food> foods;
  final List<Drink> drinks;

  Menu({required this.foods, required this.drinks});

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        foods: List.from(
          (json['foods'] as List).map((food) => Food.fromJson(food)),
        ),
        drinks: List.from(
          (json['drinks'] as List).map((drink) => Drink.fromJson(drink)),
        ),
      );
}

class Food {
  final String name;
  Food({required this.name});

  factory Food.fromJson(Map<String, dynamic> json) => Food(name: json['name']);
}

class Drink {
  final String name;
  Drink({required this.name});

  factory Drink.fromJson(Map<String, dynamic> json) =>
      Drink(name: json['name']);
}

class Category {
  final String name;
  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(name: json['name']);
}

class CustomerReviews {
  final String name;
  final String review;
  final String date;

  CustomerReviews({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReviews.fromJson(Map<String, dynamic> json) =>
      CustomerReviews(
        name: json['name'],
        review: json['review'],
        date: json['date'],
      );
}
