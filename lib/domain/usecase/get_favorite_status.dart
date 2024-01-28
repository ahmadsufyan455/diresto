import 'package:diresto/domain/repositories/app_repository.dart';

class GetFavoriteStatus {
  final AppRepository appRepository;
  GetFavoriteStatus({required this.appRepository});

  Future<bool> execute(String id) => appRepository.isAddedToFavorite(id);
}
