import 'package:diresto/data/model/restaurant.dart';
import 'package:diresto/domain/usecase/get_favorites.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteCubitState> {
  final GetFavorites getFavorites;
  FavoriteCubit({required this.getFavorites}) : super(FavoriteInitial());

  void loadFavorite() async {
    emit(FavoriteLoading());
    final result = await getFavorites.execute();
    result.fold(
      (failure) => emit(FavoriteError(failure.message)),
      (data) => emit(FavoriteLoaded(data)),
    );
  }
}
