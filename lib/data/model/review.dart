import 'package:diresto/data/model/detail_restaurant.dart';

class Review {
  final List<CustomerReviews> customerReviews;
  Review({required this.customerReviews});

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        customerReviews: List.from((json['customerReviews'] as List)
            .map((reviews) => CustomerReviews.fromJson(reviews))),
      );
}

class RequestReview {
  final String id;
  final String name;
  final String review;

  RequestReview({
    required this.id,
    required this.name,
    required this.review,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'review': review,
      };
}
