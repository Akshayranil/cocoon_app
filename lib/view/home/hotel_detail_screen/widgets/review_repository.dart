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
          const Text("User Reviews",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 24),
                        const SizedBox(width: 4),
                        Text(
                          state.averageRating.toStringAsFixed(1),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(" / 5.0"),
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
                            title: Text(review.userName),
                            subtitle: Text(review.comment),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.amber, size: 18),
                                Text(review.rating.toString()),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 15),
                    // 📝 Add new review
                    if (user != null)
                      AddReviewForm(hotelId: hotelId, user: user),
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

class AddReviewForm extends StatefulWidget {
  final String hotelId;
  final User user;
  const AddReviewForm({super.key, required this.hotelId, required this.user});

  @override
  State<AddReviewForm> createState() => _AddReviewFormState();
}

class _AddReviewFormState extends State<AddReviewForm> {
  final _controller = TextEditingController();
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Leave a review:", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: () {
                setState(() {
                  rating = index + 1.0;
                });
              },
            );
          }),
        ),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: "Write your comment...",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            final review = HotelReviewModel(
              id: '',
              hotelId: widget.hotelId,
              userId: widget.user.uid,
              userName: widget.user.displayName ?? 'Anonymous',
              comment: _controller.text.trim(),
              rating: rating,
              createdAt: DateTime.now(),
            );

            context.read<ReviewBloc>().add(AddReview(review));
            context.read<ReviewBloc>().add(FetchReviews(widget.hotelId)); // refresh
            _controller.clear();
            setState(() => rating = 0);
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
