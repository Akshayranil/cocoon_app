import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  // Sample Terms & Conditions text (replace with real one)
  final String termsText = '''
Welcome to Cocoon!

1. Acceptance of Terms
By using this app, you agree to these Terms & Conditions. If you do not agree, please do not use the app.

2. Use of Service
You agree to use this service only for lawful purposes and in a way that does not infringe the rights of others.

3. Privacy
We collect and use data as described in our Privacy Policy.

4. Intellectual Property
All content and materials are owned by [Your Company] or its licensors.

5. Limitation of Liability
[Your Company] is not responsible for any damages arising from the use of this app.

6. Updates to Terms
We may modify these terms at any time. Continued use means you accept the changes.

7. Contact Us
If you have questions, contact us at support@yourapp.com.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text('Terms & Conditions'),
        centerTitle: true,
        elevation: 1,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: SelectableText(
                  termsText,
                  style: const TextStyle(fontSize: 14.5, height: 1.5),
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // // Privacy Policy Button
                  // TextButton(
                  //   onPressed: () {
                  //     // TODO: Navigate to Privacy Policy Screen
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(
                  //           content:
                  //               Text('Open Privacy Policy (wire this up).')),
                  //     );
                  //   },
                  //   child: const Text('View Privacy Policy'),
                  // ),

                  // Accept Button
                  ElevatedButton(
                    onPressed: () {
                      // Return true to parent screen
                      Navigator.pop(context, true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      foregroundColor: AppColor.secondary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    child: const Text('Accept'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
