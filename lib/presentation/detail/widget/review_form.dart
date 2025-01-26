import 'package:diresto/data/model/review.dart';
import 'package:diresto/presentation/detail/bloc/add_review_bloc.dart';
import 'package:diresto/presentation/detail/bloc/detail_restaurant_bloc.dart';
import 'package:diresto/presentation/detail/widget/review_textfield.dart';
import 'package:diresto/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewForm extends StatelessWidget {
  final String id;
  final TextEditingController nameController;
  final TextEditingController reviewController;

  const ReviewForm({
    required this.id,
    required this.nameController,
    required this.reviewController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add review',
                  style: TextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
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
            BlocConsumer<AddReviewBloc, AddReviewState>(
              listener: (context, state) {
                if (state is AddReviewSuccess) {
                  Navigator.pop(context);
                  BlocProvider.of<DetailRestaurantBloc>(context)
                      .add(LoadDetailRestaurant(id: id));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(
                        seconds: 1,
                      ),
                      content: Text(
                        'Your review has been added',
                        style: TextStyles.body,
                      ),
                    ),
                  );
                } else if (state is AddReviewError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(
                        seconds: 1,
                      ),
                      content: Text(
                        state.message,
                        style: TextStyles.body,
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AddReviewLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    final requestData = RequestReview(
                      id: id,
                      name: nameController.text,
                      review: reviewController.text,
                    ).toJson();
                    BlocProvider.of<AddReviewBloc>(context).add(
                      AddCustomerReview(
                        data: requestData,
                      ),
                    );
                  },
                  child: Text(
                    'Add Review',
                    style: TextStyles.body,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
