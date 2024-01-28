part of 'add_review_bloc.dart';

@immutable
sealed class AddReviewState extends Equatable {
  const AddReviewState();

  @override
  List<Object> get props => [];
}

final class AddReviewInitial extends AddReviewState {}

final class AddReviewLoading extends AddReviewState {}

final class AddReviewSuccess extends AddReviewState {
  final Review data;
  const AddReviewSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class AddReviewError extends AddReviewState {
  final String message;
  const AddReviewError(this.message);

  @override
  List<Object> get props => [message];
}
