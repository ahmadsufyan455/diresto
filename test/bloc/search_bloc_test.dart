import 'package:dartz/dartz.dart';
import 'package:diresto/data/model/search_restaurant.dart';
import 'package:diresto/domain/usecase/get_search_restaurants.dart';
import 'package:diresto/presentation/search/bloc/search_bloc.dart';
import 'package:diresto/utils/constants.dart';
import 'package:diresto/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([GetSearchRestaurants])
void main() {
  late SearchBloc searchBloc;
  late MockGetSearchRestaurants mockGetSearchRestaurants;

  setUp(() {
    mockGetSearchRestaurants = MockGetSearchRestaurants();
    searchBloc = SearchBloc(getSearchRestaurants: mockGetSearchRestaurants);
  });

  test('initial should be empty', () {
    expect(searchBloc.state, SearchInitial());
  });

  final restaurant = SearchRestaurant(
    id: 'rqdv5juczeskfw1e867',
    name: 'Melting Pot',
    description:
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.',
    pictureId: '14',
    city: 'Medan',
    rating: 4.2,
  );

  final listRestaurant =
      SearchRestaurants(founded: 1, restaurants: [restaurant]);
  const query = 'Melting';

  blocTest<SearchBloc, SearchState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetSearchRestaurants.execute(query))
          .thenAnswer((_) async => right(listRestaurant));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const LoadSearchRestaurants(query: query)),
    expect: () => <SearchState>[SearchLoading(), SearchLoaded(listRestaurant)],
    verify: (bloc) => verify(mockGetSearchRestaurants.execute(query)),
  );

  blocTest<SearchBloc, SearchState>(
    'emits [Loading, Loaded] when data is unsuccessfull load',
    build: () {
      when(mockGetSearchRestaurants.execute(query)).thenAnswer(
          (_) async => left(const ServerFailure(serverFailureMessage)));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const LoadSearchRestaurants(query: query)),
    expect: () => <SearchState>[
      SearchLoading(),
      const SearchError(serverFailureMessage),
    ],
    verify: (bloc) => verify(mockGetSearchRestaurants.execute(query)),
  );
}
