import 'package:cached_network_image/cached_network_image.dart';
import 'package:diresto/data/model/detail_restaurant.dart';
import 'package:diresto/data/model/review.dart';
import 'package:diresto/presentation/detail/bloc/add_review_bloc.dart';
import 'package:diresto/presentation/detail/bloc/detail_restaurant_bloc.dart';
import 'package:diresto/presentation/detail/bloc/favorite_bloc.dart';
import 'package:diresto/presentation/detail/widget/button_favorite.dart';
import 'package:diresto/presentation/detail/widget/item_menu.dart';
import 'package:diresto/presentation/detail/widget/item_review.dart';
import 'package:diresto/presentation/detail/widget/review_textfield.dart';
import 'package:diresto/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';

import '../../utils/constants.dart';
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
      backgroundColor: Colors.white,
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

class DetailData extends StatelessWidget {
  final DetailRestaurantData data;
  final TextEditingController nameController;
  final TextEditingController reviewController;
  final bool isAddedToFavorite;
  const DetailData({
    required this.data,
    required this.nameController,
    required this.reviewController,
    required this.isAddedToFavorite,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: data.pictureId,
          child: CachedNetworkImage(
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            imageUrl: baseImageURL + data.pictureId,
            progressIndicatorBuilder: (_, __, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.7,
          minChildSize: 0.5,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16.0),
                ),
              ),
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: 5.0,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.name, style: TextStyles.title),
                            const SizedBox(height: 4.0),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow.shade700,
                                ),
                                Text(
                                  '(${data.rating})',
                                  style: TextStyles.body,
                                )
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.red.shade300,
                                ),
                                Text(
                                  data.city,
                                  style: TextStyles.body,
                                ),
                                Text(
                                  ' (${data.address})',
                                  style: TextStyles.body,
                                ),
                              ],
                            )
                          ],
                        ),
                        ButtonFavorite(
                            data: data, isAddedToFavorite: isAddedToFavorite),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    ReadMoreText(
                      '${data.description} ',
                      trimLines: 6,
                      trimMode: TrimMode.Line,
                      moreStyle: TextStyles.body.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                      lessStyle: TextStyles.body.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                      style: TextStyles.body,
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(
                          Icons.label_important_outline_rounded,
                          color: Colors.deepPurple.shade300,
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: SizedBox(
                            height: 30.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.categories.length,
                              itemBuilder: (context, index) {
                                final categories = data.categories
                                    .map((category) => category.name)
                                    .toList();
                                return ItemMenu(
                                  name: categories[index],
                                  color: Colors.deepPurple.shade100,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Food Menu',
                      style:
                          TextStyles.body.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 50.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.menu.foods.length,
                        itemBuilder: (context, index) {
                          final foods =
                              data.menu.foods.map((food) => food.name).toList();
                          return ItemMenu(name: foods[index]);
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Drink Menu',
                      style:
                          TextStyles.body.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 50.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.menu.drinks.length,
                        itemBuilder: (context, index) {
                          final drink = data.menu.drinks
                              .map((drink) => drink.name)
                              .toList();
                          return ItemMenu(name: drink[index]);
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => showModalBottomSheet(
                            context: context,
                            builder: (context) => Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 8.0,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Add review',
                                            style: TextStyles.body.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            icon:
                                                const Icon(Icons.close_rounded),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 16.0),
                                      ReviewTextField(
                                        hint: 'Name',
                                        controller: nameController,
                                        textInputAction: TextInputAction.next,
                                      ),
                                      const SizedBox(height: 10.0),
                                      ReviewTextField(
                                        hint: 'Review',
                                        maxLines: 4,
                                        controller: reviewController,
                                        textInputAction: TextInputAction.done,
                                      ),
                                      const SizedBox(height: 10.0),
                                      BlocConsumer<AddReviewBloc,
                                          AddReviewState>(
                                        listener: (context, state) {
                                          if (state is AddReviewSuccess) {
                                            Navigator.pop(context);
                                            BlocProvider.of<
                                                        DetailRestaurantBloc>(
                                                    context)
                                                .add(LoadDetailRestaurant(
                                                    id: data.id));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    duration: const Duration(
                                                      seconds: 1,
                                                    ),
                                                    content: Text(
                                                      'Your review has been added',
                                                      style: TextStyles.body
                                                          .copyWith(
                                                        color: Colors.white,
                                                      ),
                                                    )));
                                          } else if (state is AddReviewError) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    duration: const Duration(
                                                      seconds: 1,
                                                    ),
                                                    content: Text(
                                                      state.message,
                                                      style: TextStyles.body
                                                          .copyWith(
                                                        color: Colors.white,
                                                      ),
                                                    )));
                                          }
                                        },
                                        builder: (context, state) {
                                          if (state is AddReviewLoading) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          return ElevatedButton(
                                            style: const ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                Colors.deepPurple,
                                              ),
                                            ),
                                            onPressed: () {
                                              final requestData = RequestReview(
                                                id: data.id,
                                                name: nameController.text,
                                                review: reviewController.text,
                                              ).toJson();
                                              BlocProvider.of<AddReviewBloc>(
                                                      context)
                                                  .add(
                                                AddCustomerReview(
                                                  data: requestData,
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'Add Review',
                                              style: TextStyles.body.copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.reviews_rounded,
                                color: Colors.deepPurple,
                              ),
                              const SizedBox(width: 6.0),
                              Text(
                                'Add Review',
                                style: TextStyles.body.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.deepPurple,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.customerReviews.length,
                        itemBuilder: (context, index) {
                          return ItemReview(data: data.customerReviews[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
