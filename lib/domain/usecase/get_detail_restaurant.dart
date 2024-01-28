import 'package:dartz/dartz.dart';
import 'package:diresto/data/model/detail_restaurant.dart';
import 'package:diresto/domain/repositories/app_repository.dart';
import 'package:diresto/utils/failure.dart';

class GetDetailRestaurant {
  final AppRepository appRepository;
  GetDetailRestaurant({required this.appRepository});

  Future<Either<Failure, DetailRestaurant>> execute(String id) =>
      appRepository.getDetailRestaurant(id);
}
