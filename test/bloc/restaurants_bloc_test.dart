import 'package:dartz/dartz.dart';
import 'package:diresto/data/model/restaurant.dart';
import 'package:diresto/domain/usecase/get_restaurants.dart';
import 'package:diresto/presentation/list/bloc/restaurants_bloc.dart';
import 'package:diresto/utils/constants.dart';
import 'package:diresto/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import 'restaurants_bloc_test.mocks.dart';

@GenerateMocks([GetRestaurants])
void main() {
  late RestaurantsBloc restaurantsBloc;
  late MockGetRestaurants mockGetRestaurants;

  setUp(() {
    mockGetRestaurants = MockGetRestaurants();
    restaurantsBloc = RestaurantsBloc(getRestaurants: mockGetRestaurants);
  });

  test('initial should be empty', () {
    expect(restaurantsBloc.state, RestaurantsInitial());
  });

  const restaurant = Restaurant(
    id: 'rqdv5juczeskfw1e867',
    name: 'Melting Pot',
    description:
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.',
    pictureId: '14',
    city: 'Medan',
    rating: 4.2,
  );

  final listRestaurant = Restaurants(restaurants: [restaurant]);

  blocTest<RestaurantsBloc, RestaurantsState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetRestaurants.execute())
          .thenAnswer((_) async => right(listRestaurant));
      return restaurantsBloc;
    },
    act: (bloc) => bloc.add(LoadRestaurants()),
    expect: () => <RestaurantsState>[
      RestaurantsLoading(),
      RestaurantsLoaded(listRestaurant)
    ],
    verify: (bloc) => verify(mockGetRestaurants.execute()),
  );

  blocTest<RestaurantsBloc, RestaurantsState>(
    'emits [Loading, Error] when data is unsuccessfull load',
    build: () {
      when(mockGetRestaurants.execute()).thenAnswer(
          (_) async => left(const ServerFailure(serverFailureMessage)));
      return restaurantsBloc;
    },
    act: (bloc) => bloc.add(LoadRestaurants()),
    expect: () => <RestaurantsState>[
      RestaurantsLoading(),
      const RestaurantsError(serverFailureMessage)
    ],
    verify: (bloc) => verify(mockGetRestaurants.execute()),
  );
}
