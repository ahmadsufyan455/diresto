import 'package:diresto/presentation/detail/bloc/detail_restaurant_bloc.dart';
import 'package:diresto/presentation/detail/bloc/favorite_bloc.dart';
import 'package:diresto/presentation/detail/widget/detail_data.dart';
import 'package:diresto/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/error_data.dart';

class DetailRestaurantScreen extends StatefulWidget {
  static const routeName = '/detail';
  final String id;
  const DetailRestaurantScreen({required this.id, super.key});

  @override
  State<DetailRestaurantScreen> createState() => _DetailRestaurantScreenState();
}

class _DetailRestaurantScreenState extends State<DetailRestaurantScreen> {
  final nameController = TextEditingController();
  final reviewController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<DetailRestaurantBloc>(context)
        .add(LoadDetailRestaurant(id: widget.id));
    BlocProvider.of<FavoriteBloc>(context).add(LoadFavoriteStatus(widget.id));
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAddedToFavorite = context.select<FavoriteBloc, bool>(
      (bloc) => (bloc.state is FavoriteStatusAdded)
          ? (bloc.state as FavoriteStatusAdded).isAddedToFavorite
          : false,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Restaurant Detail', style: TextStyles.title),
      ),
      body: BlocBuilder<DetailRestaurantBloc, DetailRestaurantState>(
        builder: (context, state) {
          if (state is DetailRestaurantLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailRestaurantLoaded) {
            return DetailData(
              data: state.data.detailRestaurantData,
              nameController: nameController,
              reviewController: reviewController,
              isAddedToFavorite: isAddedToFavorite,
            );
          } else if (state is DetailRestaurantError) {
            return ErrorData(
              message: state.message,
              onRefresh: () =>
                  BlocProvider.of<DetailRestaurantBloc>(context).add(
                LoadDetailRestaurant(id: widget.id),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
