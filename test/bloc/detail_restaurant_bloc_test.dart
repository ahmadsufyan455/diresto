import 'package:dartz/dartz.dart';
import 'package:diresto/data/model/detail_restaurant.dart';
import 'package:diresto/domain/usecase/get_detail_restaurant.dart';
import 'package:diresto/presentation/detail/bloc/detail_restaurant_bloc.dart';
import 'package:diresto/utils/constants.dart';
import 'package:diresto/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import 'detail_restaurant_bloc_test.mocks.dart';

@GenerateMocks([GetDetailRestaurant])
void main() {
  late DetailRestaurantBloc detailRestaurantBloc;
  late MockGetDetailRestaurant mockGetDetailRestaurant;

  setUp(() {
    mockGetDetailRestaurant = MockGetDetailRestaurant();
    detailRestaurantBloc =
        DetailRestaurantBloc(getDetailRestaurant: mockGetDetailRestaurant);
  });

  test('initial should be empty', () {
    expect(detailRestaurantBloc.state, DetailRestaurantInitial());
  });

  final detailRestaurantData = DetailRestaurantData(
    id: 'rqdv5juczeskfw1e867',
    name: 'Melting Pot',
    description: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
    pictureId: '14',
    city: 'Medan',
    address: 'Jln. Belimbing Timur no 27',
    rating: 4.2,
    menu: Menu(
        foods: [Food(name: 'Paket rosemary')],
        drinks: [Drink(name: 'Es Krim')]),
    categories: [Category(name: 'Italia')],
    customerReviews: [
      CustomerReviews(
        name: 'Ahmad',
        review: 'Rekomended',
        date: '27 January 2024',
      )
    ],
  );

  final detailRestaurant =
      DetailRestaurant(detailRestaurantData: detailRestaurantData);
  const id = 'rqdv5juczeskfw1e867';

  blocTest<DetailRestaurantBloc, DetailRestaurantState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetDetailRestaurant.execute(id))
          .thenAnswer((_) async => right(detailRestaurant));
      return detailRestaurantBloc;
    },
    act: (bloc) => bloc.add(const LoadDetailRestaurant(id: id)),
    expect: () => <DetailRestaurantState>[
      DetailRestaurantLoading(),
      DetailRestaurantLoaded(detailRestaurant)
    ],
    verify: (bloc) => verify(mockGetDetailRestaurant.execute(id)),
  );

  blocTest<DetailRestaurantBloc, DetailRestaurantState>(
    'emits [Loading, Error] when data is unsuccessfull load',
    build: () {
      when(mockGetDetailRestaurant.execute(id)).thenAnswer(
          (_) async => left(const ServerFailure(serverFailureMessage)));
      return detailRestaurantBloc;
    },
    act: (bloc) => bloc.add(const LoadDetailRestaurant(id: id)),
    expect: () => <DetailRestaurantState>[
      DetailRestaurantLoading(),
      const DetailRestaurantError(serverFailureMessage)
    ],
    verify: (bloc) => verify(mockGetDetailRestaurant.execute(id)),
  );
}
