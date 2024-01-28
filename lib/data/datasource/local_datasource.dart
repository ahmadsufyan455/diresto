import 'package:diresto/data/datasource/db/database_helper.dart';
import 'package:diresto/data/model/restaurant.dart';
import 'package:diresto/utils/exception.dart';

import '../model/table_restaurant.dart';

abstract class LocalDatasource {
  Future<String> insertFavorite(TableRestaurant restaurant);
  Future<String> removeFavorite(TableRestaurant restaurant);
  Future<Restaurant?> getRestaurantById(String id);
  Future<List<Restaurant>> getFavorites();
}

class LocalDatasourceImpl implements LocalDatasource {
  final DatabaseHelper databaseHelper;
  LocalDatasourceImpl({required this.databaseHelper});

  @override
  Future<List<Restaurant>> getFavorites() async {
    final result = await databaseHelper.getFavorites();
    return result.map((data) => Restaurant.fromJson(data)).toList();
  }

  @override
  Future<Restaurant?> getRestaurantById(String id) async {
    final result = await databaseHelper.getRestaurarntById(id);
    if (result != null) {
      return Restaurant.fromJson(result);
    } else {
      return null;
    }
  }

  @override
  Future<String> insertFavorite(TableRestaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      return 'Added to favorite';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeFavorite(TableRestaurant restaurant) async {
    try {
      await databaseHelper.removeFavorite(restaurant);
      return 'Removed from favorite';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
