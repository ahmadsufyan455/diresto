import 'package:dartz/dartz.dart';
import 'package:diresto/data/model/restaurant.dart';
import 'package:diresto/domain/repositories/app_repository.dart';
import 'package:diresto/utils/failure.dart';

class GetRestaurants {
  final AppRepository appRepository;
  GetRestaurants({required this.appRepository});

  Future<Either<Failure, Restaurants>> execute() =>
      appRepository.getRestaurants();
}
