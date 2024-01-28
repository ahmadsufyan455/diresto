import 'package:dio/dio.dart';
import 'package:diresto/data/datasource/db/database_helper.dart';
import 'package:diresto/data/datasource/local_datasource.dart';
import 'package:diresto/data/datasource/remote_datasource.dart';
import 'package:diresto/data/repositories/app_repository_impl.dart';
import 'package:diresto/domain/repositories/app_repository.dart';
import 'package:diresto/domain/usecase/add_review.dart';
import 'package:diresto/domain/usecase/get_detail_restaurant.dart';
import 'package:diresto/domain/usecase/get_favorite_status.dart';
import 'package:diresto/domain/usecase/get_favorites.dart';
import 'package:diresto/domain/usecase/get_restaurants.dart';
import 'package:diresto/domain/usecase/get_search_restaurants.dart';
import 'package:diresto/domain/usecase/insert_favorite.dart';
import 'package:diresto/domain/usecase/remove_favorite.dart';
import 'package:diresto/presentation/detail/bloc/add_review_bloc.dart';
import 'package:diresto/presentation/detail/bloc/detail_restaurant_bloc.dart';
import 'package:diresto/presentation/detail/bloc/favorite_bloc.dart';
import 'package:diresto/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:diresto/presentation/list/bloc/restaurants_bloc.dart';
import 'package:diresto/presentation/search/bloc/search_bloc.dart';
import 'package:diresto/presentation/settings/cubit/settings_cubit.dart';
import 'package:diresto/utils/constants.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => RestaurantsBloc(getRestaurants: locator()));
  locator.registerFactory(() => SearchBloc(getSearchRestaurants: locator()));
  locator.registerFactory(
      () => DetailRestaurantBloc(getDetailRestaurant: locator()));
  locator.registerFactory(() => AddReviewBloc(addReview: locator()));
  locator.registerFactory(
    () => FavoriteBloc(
      insertFavorite: locator(),
      removeFavorite: locator(),
      getFavoriteStatus: locator(),
    ),
  );
  locator.registerFactory(() => FavoriteCubit(getFavorites: locator()));
  locator.registerFactory(() => SettingsCubit());

  // usecase
  locator.registerLazySingleton(() => GetRestaurants(appRepository: locator()));
  locator.registerLazySingleton(
      () => GetDetailRestaurant(appRepository: locator()));
  locator.registerLazySingleton(
      () => GetSearchRestaurants(appRepository: locator()));
  locator.registerLazySingleton(() => AddReview(appRepository: locator()));
  locator.registerLazySingleton(() => InsertFavorite(appRepository: locator()));
  locator.registerLazySingleton(() => RemoveFavorite(appRepository: locator()));
  locator
      .registerLazySingleton(() => GetFavoriteStatus(appRepository: locator()));
  locator.registerLazySingleton(() => GetFavorites(appRepository: locator()));

  // repository
  locator.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(
      remoteDatasource: locator(), localDatasource: locator()));

  // data source
  locator.registerLazySingleton<RemoteDatasource>(
    () => RemoteDatasourceImpl(dio: Dio(BaseOptions(baseUrl: baseURL))),
  );
  locator.registerLazySingleton<LocalDatasource>(
      () => LocalDatasourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
}
