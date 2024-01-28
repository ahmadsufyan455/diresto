import 'package:dio/dio.dart';
import 'package:diresto/data/model/detail_restaurant.dart';
import 'package:diresto/data/model/restaurant.dart';
import 'package:diresto/data/model/review.dart';
import 'package:diresto/data/model/search_restaurant.dart';

abstract class RemoteDatasource {
  Future<Restaurants> getRestaurants();
  Future<DetailRestaurant> getDetailRestaurant(String id);
  Future<SearchRestaurants> getSearchRestaurants(String query);
  Future<Review> addReview(Map<String, dynamic> data);
}

class RemoteDatasourceImpl implements RemoteDatasource {
  final Dio dio;
  RemoteDatasourceImpl({required this.dio});

  @override
  Future<Restaurants> getRestaurants() async {
    final response = await dio.get('/list');
    return Restaurants.fromJson(response.data);
  }

  @override
  Future<DetailRestaurant> getDetailRestaurant(String id) async {
    final response = await dio.get('/detail/$id');
    return DetailRestaurant.fromJson(response.data);
  }

  @override
  Future<SearchRestaurants> getSearchRestaurants(String query) async {
    final response = await dio.get('/search', queryParameters: {'q': query});
    return SearchRestaurants.fromJson(response.data);
  }

  @override
  Future<Review> addReview(Map<String, dynamic> data) async {
    final response = await dio.post('/review', data: data);
    return Review.fromJson(response.data);
  }
}
