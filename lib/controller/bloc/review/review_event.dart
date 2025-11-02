

import 'package:cocoon_app/model/review_model.dart';

abstract class ReviewEvent {}

class FetchReviews extends ReviewEvent {
  final String hotelId;
  FetchReviews(this.hotelId);
}

class AddReview extends ReviewEvent {
  final HotelReviewModel review;
  AddReview(this.review);
}
