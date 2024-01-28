part of 'search_bloc.dart';

@immutable
sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

final class LoadSearchRestaurants extends SearchEvent {
  final String query;
  const LoadSearchRestaurants({required this.query});

  @override
  List<Object> get props => [query];
}
