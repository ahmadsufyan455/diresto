import 'package:dartz/dartz.dart';
import 'package:diresto/data/model/review.dart';

import '../../data/model/detail_restaurant.dart';
import '../../data/model/restaurant.dart';
import '../../data/model/search_restaurant.dart';
import '../../utils/failure.dart';

abstract class AppRepository {
  // remote
  Future<Either<Failure, Restaurants>> getRestaurants();
  Future<Either<Failure, DetailRestaurant>> getDetailRestaurant(String id);
  Future<Either<Failure, SearchRestaurants>> getSearchRestaurants(String query);
  Future<Either<Failure, Review>> addReview(Map<String, dynamic> data);

  // local
  Future<Either<Failure, String>> insertFavorite(
      DetailRestaurantData restaurantData);
  Future<Either<Failure, String>> removeFavorite(
      DetailRestaurantData restaurantData);
  Future<bool> isAddedToFavorite(String id);
  Future<Either<Failure, List<Restaurant>>> getFavorites();
}
