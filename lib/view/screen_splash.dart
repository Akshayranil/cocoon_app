import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:cocoon_app/view/screen_getstarted.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((_){
       Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => GetStartedScreen()),
    );
    });
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.ternary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/cocoon.png'),
            Text(
              'Cocoon',
              style: TextStyle(fontSize: 32, color: AppColor.secondary),
            ),
          ],
        ),
      ),
    );
  }
}
