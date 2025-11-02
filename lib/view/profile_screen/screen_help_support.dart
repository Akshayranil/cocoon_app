import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Support"),
        centerTitle: true,
        backgroundColor: AppColor.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Help & Support",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "We’re here to assist you with bookings, payments, or any app-related questions.",
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
            SizedBox(height: 20),
            Text(
              "Frequently Asked Questions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "• How can I modify or cancel a booking?\n"
              "Go to 'My Bookings' → Select your booking → Choose Modify or Cancel.\n\n"
              "• I didn't receive a booking confirmation.\n"
              "Check your spam folder or confirm your email address is correct.\n\n"
              "• My payment failed but the amount was deducted.\n"
              "It's usually refunded within 5-7 working days. If not, contact support.\n\n"
              "• Do you charge booking fees?\n"
              "No, we do not charge any extra fees beyond what is shown in the app.",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 20),
            Text(
              "Contact Us",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "If you need help, feel free to contact our support team:\n"
              "Email: akshay08032002@gmail.com\n"
              "Phone: +91 9746732747\n\n"
              "Our support team is available 24/7 to assist you.",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                "© 2025 Cocoon. All rights reserved.",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
