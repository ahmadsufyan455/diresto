import 'package:diresto/data/model/review.dart';
import 'package:diresto/domain/usecase/add_review.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_review_event.dart';
part 'add_review_state.dart';

class AddReviewBloc extends Bloc<AddReviewEvent, AddReviewState> {
  final AddReview addReview;
  AddReviewBloc({required this.addReview}) : super(AddReviewInitial()) {
    on<AddCustomerReview>((event, emit) async {
      emit(AddReviewLoading());
      final result = await addReview.execute(event.data);
      result.fold(
        (failure) => emit(AddReviewError(failure.message)),
        (data) => emit(AddReviewSuccess(data)),
      );
    });
  }
}
