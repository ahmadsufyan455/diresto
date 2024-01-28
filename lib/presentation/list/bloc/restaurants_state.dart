part of 'restaurants_bloc.dart';

@immutable
sealed class RestaurantsState extends Equatable {
  const RestaurantsState();

  @override
  List<Object> get props => [];
}

final class RestaurantsInitial extends RestaurantsState {}

final class RestaurantsLoading extends RestaurantsState {}

final class RestaurantsLoaded extends RestaurantsState {
  final Restaurants data;
  const RestaurantsLoaded(this.data);

  @override
  List<Object> get props => [data];
}

final class RestaurantsError extends RestaurantsState {
  final String message;
  const RestaurantsError(this.message);

  @override
  List<Object> get props => [message];
}
