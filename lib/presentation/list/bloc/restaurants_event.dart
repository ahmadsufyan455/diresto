part of 'restaurants_bloc.dart';

@immutable
sealed class RestaurantsEvent extends Equatable {
  const RestaurantsEvent();

  @override
  List<Object> get props => [];
}

final class LoadRestaurants extends RestaurantsEvent {}
