part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {
  const FavoriteEvent();
}

final class AddToFavorite extends FavoriteEvent {
  final DetailRestaurantData restaurantData;
  const AddToFavorite(this.restaurantData);
}

final class RemoveFromFavorite extends FavoriteEvent {
  final DetailRestaurantData restaurantData;
  const RemoveFromFavorite(this.restaurantData);
}

final class LoadFavoriteStatus extends FavoriteEvent {
  final String id;
  const LoadFavoriteStatus(this.id);
}
