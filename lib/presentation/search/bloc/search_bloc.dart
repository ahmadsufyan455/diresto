import 'package:diresto/domain/usecase/get_search_restaurants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/search_restaurant.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSearchRestaurants getSearchRestaurants;
  SearchBloc({required this.getSearchRestaurants}) : super(SearchInitial()) {
    on<LoadSearchRestaurants>((event, emit) async {
      emit(SearchLoading());
      final result = await getSearchRestaurants.execute(event.query);
      result.fold(
        (failure) => emit(SearchError(failure.message)),
        (data) => emit(SearchLoaded(data)),
      );
    });
  }
}
