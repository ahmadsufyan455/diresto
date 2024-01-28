import 'package:flutter/material.dart';

import '../../../data/model/detail_restaurant.dart';
import '../../../utils/text_styles.dart';

class ItemReview extends StatelessWidget {
  final CustomerReviews data;
  final Color? color;
  const ItemReview({required this.data, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.name,
            style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 2.0),
          Text(
            data.review,
            style: TextStyles.body,
          ),
          const SizedBox(height: 6.0),
          Text(
            data.date,
            style: TextStyles.body.copyWith(
              color: Colors.deepPurple.shade200,
            ),
          )
        ],
      ),
    );
  }
}
