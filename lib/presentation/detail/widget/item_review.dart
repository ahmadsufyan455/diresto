import 'package:flutter/material.dart';

import '../../../data/model/detail_restaurant.dart';
import '../../../utils/text_styles.dart';

class ItemReview extends StatelessWidget {
  final CustomerReviews data;
  const ItemReview({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.name,
            style: TextStyles.body.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            data.review,
            style: TextStyles.body.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            data.date,
            style: TextStyles.body.copyWith(
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
          )
        ],
      ),
    );
  }
}
