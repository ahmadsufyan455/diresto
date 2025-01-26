import 'package:cached_network_image/cached_network_image.dart';
import 'package:diresto/data/model/detail_restaurant.dart';
import 'package:diresto/presentation/detail/widget/button_favorite.dart';
import 'package:diresto/presentation/detail/widget/item_menu.dart';
import 'package:diresto/presentation/detail/widget/item_review.dart';
import 'package:diresto/presentation/detail/widget/review_form.dart';
import 'package:diresto/utils/constants.dart';
import 'package:diresto/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

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
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.4,
            fit: BoxFit.cover,
            imageUrl: baseImageURL + data.pictureId,
            progressIndicatorBuilder: (_, __, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.6,
          maxChildSize: 1,
          minChildSize: 0.6,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
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
                          Expanded(
                            child: Column(
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
                                    Flexible(
                                      child: Text(
                                        ' (${data.address})',
                                        style: TextStyles.body,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
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
                            color: Theme.of(context).colorScheme.secondary,
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
                        style: TextStyles.body
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10.0),
                      SizedBox(
                        height: 50.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.menu.foods.length,
                          itemBuilder: (context, index) {
                            final foods = data.menu.foods
                                .map((food) => food.name)
                                .toList();
                            return ItemMenu(name: foods[index]);
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Drink Menu',
                        style: TextStyles.body
                            .copyWith(fontWeight: FontWeight.w600),
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
                            onPressed: () => showReviewForm(
                              context: context,
                              id: data.id,
                              nameController: nameController,
                              reviewController: reviewController,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.reviews_rounded,
                                ),
                                const SizedBox(width: 6.0),
                                Text(
                                  'Add Review',
                                  style: TextStyles.body,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.customerReviews.length,
                        itemBuilder: (context, index) {
                          return ItemReview(data: data.customerReviews[index]);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

void showReviewForm({
  required BuildContext context,
  required String id,
  required TextEditingController nameController,
  required TextEditingController reviewController,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: ReviewForm(
        id: id,
        nameController: nameController,
        reviewController: reviewController,
      ),
    ),
  );
}
