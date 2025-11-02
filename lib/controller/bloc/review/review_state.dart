
import 'package:cocoon_app/model/review_model.dart';

abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewLoaded extends ReviewState {
  final List<HotelReviewModel> reviews;
  final double averageRating;

  ReviewLoaded(this.reviews, this.averageRating);
}

class ReviewError extends ReviewState {
  final String message;
  ReviewError(this.message);
}
