part of 'detail_restaurant_bloc.dart';

@immutable
sealed class DetailRestaurantEvent extends Equatable {
  const DetailRestaurantEvent();

  @override
  List<Object> get props => [];
}

final class LoadDetailRestaurant extends DetailRestaurantEvent {
  final String id;
  const LoadDetailRestaurant({required this.id});

  @override
  List<Object> get props => [id];
}
