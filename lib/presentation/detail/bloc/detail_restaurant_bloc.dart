import 'package:diresto/data/model/detail_restaurant.dart';
import 'package:diresto/domain/usecase/get_detail_restaurant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_restaurant_event.dart';
part 'detail_restaurant_state.dart';

class DetailRestaurantBloc
    extends Bloc<DetailRestaurantEvent, DetailRestaurantState> {
  final GetDetailRestaurant getDetailRestaurant;
  DetailRestaurantBloc({required this.getDetailRestaurant})
      : super(DetailRestaurantInitial()) {
    on<LoadDetailRestaurant>((event, emit) async {
      emit(DetailRestaurantLoading());
      final result = await getDetailRestaurant.execute(event.id);
      result.fold(
        (failure) => emit(DetailRestaurantError(failure.message)),
        (data) => emit(DetailRestaurantLoaded(data)),
      );
    });
  }
}
