import 'package:diresto/data/model/restaurant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/get_restaurants.dart';

part 'restaurants_event.dart';
part 'restaurants_state.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  final GetRestaurants getRestaurants;
  RestaurantsBloc({required this.getRestaurants})
      : super(RestaurantsInitial()) {
    on<LoadRestaurants>((event, emit) async {
      emit(RestaurantsLoading());
      final result = await getRestaurants.execute();
      result.fold(
        (failure) => emit(RestaurantsError(failure.message)),
        (data) => emit(RestaurantsLoaded(data)),
      );
    });
  }
}
