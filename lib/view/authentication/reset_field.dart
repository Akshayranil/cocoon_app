import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:cocoon_app/utilities/forgot_password.dart';
import 'package:flutter/material.dart';

class ResetPasswordField extends StatelessWidget {
  const ResetPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            final TextEditingController emailcontroller =
                TextEditingController();
            return AlertDialog(
              title: Text(
                'Reset Password',
                style: TextStyle(
                  color: AppColor.ternary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    resetPassword(context, emailcontroller.text.trim());
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                  ),
                  child: Text(
                    'Sent',
                    style: TextStyle(color: AppColor.secondary),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Text('Forgot Password?'),
    );
  }
}
