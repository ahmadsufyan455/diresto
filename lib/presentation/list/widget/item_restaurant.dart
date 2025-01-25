import 'package:cached_network_image/cached_network_image.dart';
import 'package:diresto/utils/constants.dart';
import 'package:diresto/utils/text_styles.dart';
import 'package:flutter/material.dart';

class ItemRestaurant extends StatelessWidget {
  final dynamic restaurant;

  const ItemRestaurant({required this.restaurant, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: restaurant.pictureId,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  imageUrl: baseImageURL + restaurant.pictureId,
                  placeholder: (context, url) => Image.asset(
                    'assets/placeholder.jpg',
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(restaurant.name, style: TextStyles.title),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(restaurant.city, style: TextStyles.body),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow.shade700),
                          Text('(${restaurant.rating})')
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
