import 'package:cocoon_app/controller/bloc/review/review_bloc.dart';
import 'package:cocoon_app/controller/bloc/review/review_event.dart';
import 'package:cocoon_app/controller/bloc/review/review_state.dart';
import 'package:cocoon_app/model/review_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotelReviewSection extends StatelessWidget {
  final String hotelId;
  const HotelReviewSection({super.key, required this.hotelId});

  @override
  Widget build(BuildContext context) {
    context.read<ReviewBloc>().add(FetchReviews(hotelId));

    final user = FirebaseAuth.instance.currentUser;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "User Reviews",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          BlocBuilder<ReviewBloc, ReviewState>(
            builder: (context, state) {
              if (state is ReviewLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ReviewError) {
                return Text(state.message);
              } else if (state is ReviewLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ⭐ Average rating
                    // ⭐ Average rating or first review message
                    state.reviews.isEmpty || state.averageRating == 0
                        ? const Text(
                            "Be the first one to review",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 24,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                state.averageRating.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(" / 5.0"),
                            ],
                          ),

                    const SizedBox(height: 10),

                    // 🧍 List of reviews
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.reviews.length,
                      itemBuilder: (context, index) {
                        final review = state.reviews[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(review.guestName??'No user'),
                            subtitle: Text(review.comment),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                                Text(review.rating.toString()),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 15),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
