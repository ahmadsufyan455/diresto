import 'package:diresto/data/model/detail_restaurant.dart';
import 'package:diresto/domain/usecase/get_favorite_status.dart';
import 'package:diresto/domain/usecase/insert_favorite.dart';
import 'package:diresto/domain/usecase/remove_favorite.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final InsertFavorite insertFavorite;
  final RemoveFavorite removeFavorite;

  final GetFavoriteStatus getFavoriteStatus;
  FavoriteBloc({
    required this.insertFavorite,
    required this.removeFavorite,
    required this.getFavoriteStatus,
  }) : super(FavoriteInitial()) {
    on<AddToFavorite>((event, emit) async {
      final result = await insertFavorite.execute(event.restaurantData);
      result.fold(
        (failure) => emit(FailedMessage(failure.message)),
        (message) => emit(SuccessMessage(message)),
      );
    });

    on<RemoveFromFavorite>((event, emit) async {
      final result = await removeFavorite.execute(event.restaurantData);
      result.fold(
        (failure) => emit(FailedMessage(failure.message)),
        (message) => emit(SuccessMessage(message)),
      );
    });

    on<LoadFavoriteStatus>((event, emit) async {
      final result = await getFavoriteStatus.execute(event.id);
      emit(FavoriteStatusAdded(result));
    });
  }
}
