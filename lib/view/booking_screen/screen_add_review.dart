import 'package:cocoon_app/controller/bloc/review/review_bloc.dart';
import 'package:cocoon_app/controller/bloc/review/review_event.dart';
import 'package:cocoon_app/model/review_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddReviewScreen extends StatelessWidget {
  final String hotelId;
  final String hotelName;

  AddReviewScreen({required this.hotelId, required this.hotelName, super.key});

  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<double> ratingNotifier = ValueNotifier<double>(0);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(title: Text("Review: $hotelName")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Rate your experience"),
            
            // ⭐ Rating Row
            ValueListenableBuilder<double>(
              valueListenable: ratingNotifier,
              builder: (context, rating, _) {
                return Row(
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      ),
                      onPressed: () => ratingNotifier.value = index + 1.0,
                    );
                  }),
                );
              },
            ),

            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Write your review...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                context.read<ReviewBloc>().add(AddReview(
                  HotelReviewModel(
                    id: '',
                    hotelId: hotelId,
                    userId: user.uid,
                    userName: user.displayName ?? "Guest",
                    comment: _controller.text.trim(),
                    rating: ratingNotifier.value,
                    createdAt: DateTime.now(),
                  ),
                ));
                Navigator.pop(context); // Return to Bookings screen
              },
              child: const Text("Submit Review"),
            )
          ],
        ),
      ),
    );
  }
}
