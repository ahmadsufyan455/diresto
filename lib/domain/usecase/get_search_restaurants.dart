import 'package:dartz/dartz.dart';
import 'package:diresto/data/model/search_restaurant.dart';
import 'package:diresto/domain/repositories/app_repository.dart';
import 'package:diresto/utils/failure.dart';

class GetSearchRestaurants {
  final AppRepository appRepository;
  GetSearchRestaurants({required this.appRepository});

  Future<Either<Failure, SearchRestaurants>> execute(String query) =>
      appRepository.getSearchRestaurants(query);
}
