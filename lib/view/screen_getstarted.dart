import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:cocoon_app/view/screen_login.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.center,

              child: Image.asset(
                'assets/image3.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: const Color.fromARGB(
                255,
                124,
                125,
                123,
              ).withValues(alpha: 0.5),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Cocoon',
                    style: TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.bold,
                      color: AppColor.secondary,
                    ),
                  ),
                  Text(
                    'Wherever you go, we make it feel like home.',
                    style: TextStyle(
                      color: AppColor.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 60),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    foregroundColor: AppColor.secondary,
                    minimumSize: Size(230, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'GET STARTED',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
