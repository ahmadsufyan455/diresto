part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteCubitState extends Equatable {
  const FavoriteCubitState();

  @override
  List<Object> get props => [];
}

final class FavoriteInitial extends FavoriteCubitState {}

final class FavoriteLoading extends FavoriteCubitState {}

final class FavoriteLoaded extends FavoriteCubitState {
  final List<Restaurant> data;
  const FavoriteLoaded(this.data);

  @override
  List<Object> get props => [data];
}

final class FavoriteError extends FavoriteCubitState {
  final String message;
  const FavoriteError(this.message);

  @override
  List<Object> get props => [message];
}
