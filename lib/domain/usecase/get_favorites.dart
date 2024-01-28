import 'package:dartz/dartz.dart';
import 'package:diresto/data/model/restaurant.dart';
import 'package:diresto/domain/repositories/app_repository.dart';
import 'package:diresto/utils/failure.dart';

class GetFavorites {
  final AppRepository appRepository;
  GetFavorites({required this.appRepository});

  Future<Either<Failure, List<Restaurant>>> execute() =>
      appRepository.getFavorites();
}
