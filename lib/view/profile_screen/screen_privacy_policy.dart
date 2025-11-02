import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        centerTitle: true,
        backgroundColor: AppColor.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Privacy Policy",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Effective Date: October 27, 2025",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Text(
              "1. Introduction",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              "Welcome to Cocoon. We value your trust and are committed "
              "to protecting your privacy. This policy explains how we collect, "
              "use, and safeguard your personal information.",
            ),
            SizedBox(height: 15),
            Text(
              "2. Information We Collect",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              "• Personal details such as your name, email, and phone number.\n"
              "• Booking information such as hotel name, dates, and guests.\n"
              "• Location data (only if you grant permission).\n"
              "• Payment-related information handled securely by third-party processors.",
            ),
            SizedBox(height: 15),
            Text(
              "3. How We Use Your Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              "We use your data to process hotel bookings, improve our app, send "
              "booking confirmations, and provide customer support.",
            ),
            SizedBox(height: 15),
            Text(
              "4. Sharing Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              "We do not sell your data. Information may be shared with hotels, "
              "payment partners, or legal authorities when necessary.",
            ),
            SizedBox(height: 15),
            Text(
              "5. Your Rights",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              "You can access, update, or delete your personal information at any time. "
              "For assistance, contact privacy@yourdomain.com.",
            ),
            SizedBox(height: 15),
            Text(
              "6. Contact Us",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              "If you have questions about this Privacy Policy, please contact us at:\n"
              "akshay08032002@gmail.com",
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
