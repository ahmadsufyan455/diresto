import 'package:diresto/presentation/detail/detail_restaurant_screen.dart';
import 'package:diresto/presentation/list/widget/item_restaurant.dart';
import 'package:diresto/presentation/search/bloc/search_bloc.dart';
import 'package:diresto/presentation/widget/empty_data.dart';
import 'package:diresto/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/error_data.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyles.title,
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (newQuery) {
                        setState(() {
                          query = newQuery;
                          BlocProvider.of<SearchBloc>(context).add(
                            LoadSearchRestaurants(query: query),
                          );
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search restaurants...',
                        hintStyle: TextStyles.body,
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20.0)),
                        disabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  flex: 11,
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is SearchInitial) {
                        return Center(
                          child: Text(
                            'Waiting for search...',
                            style: TextStyles.body,
                          ),
                        );
                      } else if (state is SearchLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is SearchLoaded) {
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
                                    child: ItemRestaurant(
                                      restaurant: data[index],
                                    ),
                                  );
                                },
                              );
                      } else if (state is SearchError) {
                        return ErrorData(
                          message: state.message,
                          onRefresh: () =>
                              BlocProvider.of<SearchBloc>(context).add(
                            LoadSearchRestaurants(query: query),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
