import 'package:diresto/data/model/detail_restaurant.dart';
import 'package:diresto/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favorite_bloc.dart';

class ButtonFavorite extends StatefulWidget {
  final DetailRestaurantData data;
  final bool isAddedToFavorite;
  const ButtonFavorite({
    required this.data,
    required this.isAddedToFavorite,
    super.key,
  });

  @override
  State<ButtonFavorite> createState() => _ButtonFavoriteState();
}

class _ButtonFavoriteState extends State<ButtonFavorite> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteBloc, FavoriteState>(
      listener: (context, state) {
        if (state is SuccessMessage) {
          BlocProvider.of<FavoriteBloc>(context)
              .add(LoadFavoriteStatus(widget.data.id));
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 1),
              content: Text(
                state.message,
                style: TextStyles.body.copyWith(color: Colors.white),
              ),
            ),
          );
        } else if (state is FailedMessage) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 1),
              content: Text(
                state.message,
                style: TextStyles.body.copyWith(color: Colors.white),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            if (!widget.isAddedToFavorite) {
              BlocProvider.of<FavoriteBloc>(context)
                  .add(AddToFavorite(widget.data));
            } else {
              BlocProvider.of<FavoriteBloc>(context)
                  .add(RemoveFromFavorite(widget.data));
            }
          },
          icon: Icon(
            widget.isAddedToFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red.shade300,
          ),
        );
      },
    );
  }
}
