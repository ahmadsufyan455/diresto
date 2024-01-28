part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

final class SuccessMessage extends FavoriteState {
  final String message;
  const SuccessMessage(this.message);

  @override
  List<Object> get props => [message];
}

final class FailedMessage extends FavoriteState {
  final String message;
  const FailedMessage(this.message);

  @override
  List<Object> get props => [message];
}

final class FavoriteStatusAdded extends FavoriteState {
  final bool isAddedToFavorite;
  const FavoriteStatusAdded(this.isAddedToFavorite);

  @override
  List<Object> get props => [isAddedToFavorite];
}
