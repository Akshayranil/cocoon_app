import 'package:cocoon_app/controller/bloc/review/review_bloc.dart';
import 'package:cocoon_app/controller/bloc/review/review_event.dart';
import 'package:cocoon_app/model/review_model.dart';
import 'package:cocoon_app/utilities/custom_color.dart';
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
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text("Review: $hotelName"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Rate Your Experience",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                // ⭐ Rating Bar
                ValueListenableBuilder<double>(
                  valueListenable: ratingNotifier,
                  builder: (context, rating, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () => ratingNotifier.value = index + 1.0,
                          child: Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 36,
                          ),
                        );
                      }),
                    );
                  },
                ),

                const SizedBox(height: 20),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Write a Review",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),

                TextField(
                  controller: _controller,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Tell others about your stay...",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      foregroundColor: AppColor.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (ratingNotifier.value == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select a rating"),
                          ),
                        );
                        return;
                      }

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

                      Navigator.pop(context);
                    },
                    
                    child: const Text(
                      "Submit Review",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
