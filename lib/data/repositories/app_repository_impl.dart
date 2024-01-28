import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:diresto/data/datasource/local_datasource.dart';
import 'package:diresto/data/datasource/remote_datasource.dart';
import 'package:diresto/data/model/detail_restaurant.dart';
import 'package:diresto/data/model/restaurant.dart';
import 'package:diresto/data/model/review.dart';
import 'package:diresto/data/model/search_restaurant.dart';
import 'package:diresto/data/model/table_restaurant.dart';
import 'package:diresto/domain/repositories/app_repository.dart';
import 'package:diresto/utils/constants.dart';
import 'package:diresto/utils/failure.dart';
import 'package:sqflite/sqflite.dart';

class AppRepositoryImpl implements AppRepository {
  final RemoteDatasource remoteDatasource;
  final LocalDatasource localDatasource;
  AppRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, Restaurants>> getRestaurants() async {
    try {
      final result = await remoteDatasource.getRestaurants();
      return Right(result);
    } on DioException catch (e) {
      return e.type == DioExceptionType.connectionError
          ? const Left(ConnectionFailure(errorNetworkMessage))
          : const Left(ServerFailure(serverFailureMessage));
    }
  }

  @override
  Future<Either<Failure, DetailRestaurant>> getDetailRestaurant(
      String id) async {
    try {
      final result = await remoteDatasource.getDetailRestaurant(id);
      return Right(result);
    } on DioException catch (e) {
      return e.type == DioExceptionType.connectionError
          ? const Left(ConnectionFailure(errorNetworkMessage))
          : const Left(ServerFailure(serverFailureMessage));
    }
  }

  @override
  Future<Either<Failure, SearchRestaurants>> getSearchRestaurants(
      String query) async {
    try {
      final result = await remoteDatasource.getSearchRestaurants(query);
      return Right(result);
    } on DioException catch (e) {
      return e.type == DioExceptionType.connectionError
          ? const Left(ConnectionFailure(errorNetworkMessage))
          : const Left(ServerFailure(serverFailureMessage));
    }
  }

  @override
  Future<Either<Failure, Review>> addReview(Map<String, dynamic> data) async {
    try {
      final result = await remoteDatasource.addReview(data);
      return Right(result);
    } on DioException catch (e) {
      return e.type == DioExceptionType.connectionError
          ? const Left(ConnectionFailure(errorNetworkMessage))
          : const Left(ServerFailure(serverFailureMessage));
    }
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getFavorites() async {
    final result = await localDatasource.getFavorites();
    return Right(result);
  }

  @override
  Future<Either<Failure, String>> insertFavorite(
      DetailRestaurantData restaurantData) async {
    try {
      final result = await localDatasource
          .insertFavorite(TableRestaurant.fromEntity(restaurantData));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.toString()));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isAddedToFavorite(String id) async {
    final result = await localDatasource.getRestaurantById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeFavorite(
      DetailRestaurantData restaurantData) async {
    try {
      final result = await localDatasource
          .removeFavorite(TableRestaurant.fromEntity(restaurantData));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.toString()));
    } catch (e) {
      rethrow;
    }
  }
}
