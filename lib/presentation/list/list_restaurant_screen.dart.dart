import 'package:diresto/presentation/detail/detail_restaurant_screen.dart';
import 'package:diresto/presentation/list/bloc/restaurants_bloc.dart';
import 'package:diresto/presentation/list/widget/item_restaurant.dart';
import 'package:diresto/presentation/search/search_screen.dart';
import 'package:diresto/presentation/widget/empty_data.dart';
import 'package:diresto/presentation/widget/error_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListRestaurantScreen extends StatefulWidget {
  static const routeName = '/list';
  const ListRestaurantScreen({super.key});

  @override
  State<ListRestaurantScreen> createState() => _ListRestaurantScreenState();
}

class _ListRestaurantScreenState extends State<ListRestaurantScreen> {
  Future<void> _onRefresh() async {
    BlocProvider.of<RestaurantsBloc>(context).add(LoadRestaurants());
  }

  @override
  void initState() {
    BlocProvider.of<RestaurantsBloc>(context).add(LoadRestaurants());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diresto'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(
              context,
              SearchScreen.routeName,
            ),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: BlocBuilder<RestaurantsBloc, RestaurantsState>(
          builder: (context, state) {
            if (state is RestaurantsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RestaurantsLoaded) {
              final data = state.data.restaurants;
              return data.isEmpty
                  ? const EmptyData()
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Navigator.pushNamed(
                            context,
                            DetailRestaurantScreen.routeName,
                            arguments: data[index].id,
                          ),
                          child: ItemRestaurant(restaurant: data[index]),
                        );
                      },
                    );
            } else if (state is RestaurantsError) {
              return ErrorData(
                message: state.message,
                onRefresh: () => BlocProvider.of<RestaurantsBloc>(context)
                    .add(LoadRestaurants()),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
