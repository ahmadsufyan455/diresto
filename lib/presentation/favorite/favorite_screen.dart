import 'package:diresto/presentation/detail/detail_restaurant_screen.dart';
import 'package:diresto/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:diresto/presentation/list/widget/item_restaurant.dart';
import 'package:diresto/presentation/widget/empty_data.dart';
import 'package:diresto/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favorite';
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    BlocProvider.of<FavoriteCubit>(context).loadFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Restaurant',
          style: TextStyles.title,
        ),
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteCubitState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoriteLoaded) {
            final data = state.data;
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
                        ).then(
                          (value) => BlocProvider.of<FavoriteCubit>(context)
                              .loadFavorite(),
                        ),
                        child: ItemRestaurant(restaurant: data[index]),
                      );
                    },
                  );
          } else if (state is FavoriteError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
