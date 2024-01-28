part of 'add_review_bloc.dart';

@immutable
sealed class AddReviewEvent extends Equatable {
  const AddReviewEvent();

  @override
  List<Object> get props => [];
}

final class AddCustomerReview extends AddReviewEvent {
  final Map<String, dynamic> data;
  const AddCustomerReview({required this.data});

  @override
  List<Object> get props => [data];
}
