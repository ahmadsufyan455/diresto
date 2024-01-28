import 'package:dartz/dartz.dart';
import 'package:diresto/data/model/detail_restaurant.dart';
import 'package:diresto/domain/repositories/app_repository.dart';

import '../../utils/failure.dart';

class InsertFavorite {
  final AppRepository appRepository;
  InsertFavorite({required this.appRepository});

  Future<Either<Failure, String>> execute(
          DetailRestaurantData detailRestaurantData) =>
      appRepository.insertFavorite(detailRestaurantData);
}
