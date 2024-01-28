part of 'detail_restaurant_bloc.dart';

@immutable
sealed class DetailRestaurantState extends Equatable {
  const DetailRestaurantState();

  @override
  List<Object> get props => [];
}

final class DetailRestaurantInitial extends DetailRestaurantState {}

final class DetailRestaurantLoading extends DetailRestaurantState {}

final class DetailRestaurantLoaded extends DetailRestaurantState {
  final DetailRestaurant data;
  const DetailRestaurantLoaded(this.data);

  @override
  List<Object> get props => [data];
}

final class DetailRestaurantError extends DetailRestaurantState {
  final String message;
  const DetailRestaurantError(this.message);

  @override
  List<Object> get props => [message];
}
