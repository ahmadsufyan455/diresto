import 'package:dartz/dartz.dart';
import 'package:diresto/data/model/detail_restaurant.dart';
import 'package:diresto/data/model/review.dart';
import 'package:diresto/domain/usecase/add_review.dart';
import 'package:diresto/presentation/detail/bloc/add_review_bloc.dart';
import 'package:diresto/utils/constants.dart';
import 'package:diresto/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import 'add_review_bloc_test.mocks.dart';

@GenerateMocks([AddReview])
void main() {
  late AddReviewBloc addReviewBloc;
  late MockAddReview mockAddReview;

  setUp(() {
    mockAddReview = MockAddReview();
    addReviewBloc = AddReviewBloc(addReview: mockAddReview);
  });

  final requestData = {
    'id': 'ateyf7m737ekfw1e867',
    'name': 'Dico',
    'review': 'Ntabb gan',
  };

  final review = Review(
    customerReviews: [
      CustomerReviews(
        name: 'Ahmad',
        review: 'Rekomended',
        date: '27 January 2024',
      )
    ],
  );

  test('initial should be empty', () {
    expect(addReviewBloc.state, AddReviewInitial());
  });

  blocTest<AddReviewBloc, AddReviewState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockAddReview.execute(requestData))
          .thenAnswer((_) async => right(review));
      return addReviewBloc;
    },
    act: (bloc) => bloc.add(AddCustomerReview(data: requestData)),
    expect: () =>
        <AddReviewState>[AddReviewLoading(), AddReviewSuccess(review)],
    verify: (bloc) => verify(mockAddReview.execute(requestData)),
  );

  blocTest<AddReviewBloc, AddReviewState>(
    'emits [Loading, Loaded] when data is unsuccessfully load',
    build: () {
      when(mockAddReview.execute(requestData)).thenAnswer(
          (_) async => left(const ServerFailure(serverFailureMessage)));
      return addReviewBloc;
    },
    act: (bloc) => bloc.add(AddCustomerReview(data: requestData)),
    expect: () => <AddReviewState>[
      AddReviewLoading(),
      const AddReviewError(serverFailureMessage)
    ],
    verify: (bloc) => verify(mockAddReview.execute(requestData)),
  );
}
