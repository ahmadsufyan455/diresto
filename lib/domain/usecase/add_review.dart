import 'package:dartz/dartz.dart';
import 'package:diresto/data/model/review.dart';
import 'package:diresto/domain/repositories/app_repository.dart';
import 'package:diresto/utils/failure.dart';

class AddReview {
  final AppRepository appRepository;
  AddReview({required this.appRepository});

  Future<Either<Failure, Review>> execute(Map<String, dynamic> data) =>
      appRepository.addReview(data);
}
