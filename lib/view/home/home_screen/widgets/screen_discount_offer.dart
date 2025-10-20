import 'package:flutter/material.dart';

class ScreenDiscountOffer extends StatelessWidget {
  const ScreenDiscountOffer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
                padding: EdgeInsets.only(top: 30, left: 20),
                child: Text(
                  'Best offers for you',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          
                        },
                        child: Image.asset('assets/resort.jpg')),
                      Padding(
                        padding: EdgeInsets.only(left: 30, top: 20),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Upto 40 % OFF *\n\n',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Discounts that feels \n like a vacation.',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
