import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocoon_app/model/review_model.dart';
import 'review_event.dart';
import 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final FirebaseFirestore firestore;

  ReviewBloc({required this.firestore}) : super(ReviewInitial()) {
    on<FetchReviews>(_onFetchReviews);
    on<AddReview>(_onAddReview);
  }

  Future<void> _onFetchReviews(
    FetchReviews event,
    Emitter<ReviewState> emit,
  ) async {
    try {
      emit(ReviewLoading());

      final snapshot = await firestore
          .collection('hotel_reviews')
          .where('hotelId', isEqualTo: event.hotelId)
          .orderBy('createdAt', descending: true)
          .get();

      final reviews = snapshot.docs
          .map((doc) => HotelReviewModel.fromMap(doc.id, doc.data()))
          .toList();

      final averageRating = reviews.isEmpty
          ? 0.0
          : reviews.map((r) => r.rating).reduce((a, b) => a + b) /
                reviews.length;

      emit(ReviewLoaded(reviews, averageRating));
    } catch (e) {
      emit(ReviewError('Failed to load reviews: $e'));
    }
  }

  // ✅ UPDATED METHOD - Now updates hotel rating in Firestore
  Future<void> _onAddReview(AddReview event, Emitter<ReviewState> emit) async {
    try {
      // Add the review to hotel_reviews collection
      await firestore.collection('hotel_reviews').add(event.review.toMap());

      // ✅ NEW: Fetch all reviews for this hotel to calculate average
      final snapshot = await firestore
          .collection('hotel_reviews')
          .where('hotelId', isEqualTo: event.review.hotelId)
          .get();

      final reviews = snapshot.docs
          .map((doc) => HotelReviewModel.fromMap(doc.id, doc.data()))
          .toList();

      // ✅ NEW: Calculate average rating
      final averageRating = reviews.isEmpty
          ? 0.0
          : reviews.map((r) => r.rating).reduce((a, b) => a + b) /
                reviews.length;

      // ✅ NEW: Update hotel document with new average rating and review count
      await firestore
          .collection(
            'hotelregistration',
          ) // ⚠️ Make sure this matches your collection name
          .doc(event.review.hotelId)
          .update({'rating': averageRating, 'reviewCount': reviews.length});

      // Refresh the reviews to show the newly added one
      add(FetchReviews(event.review.hotelId));
    } catch (e) {
      emit(ReviewError('Failed to add review: $e'));
    }
  }
}
