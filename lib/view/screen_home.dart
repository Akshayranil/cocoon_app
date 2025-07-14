import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.only(left: 35,top: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Kannur , Kerala',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30,top: 10,right: 60),
                child: TextField(
                  
                  decoration: InputDecoration(
                    hintText: 'Search hotel,location etc',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30,left: 30),
                child: Text('Best offers for you',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)),
              
              Padding(
                padding: EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: [
                      Image.asset('assets/resort.jpg'),
                      Padding(
                        padding: EdgeInsets.only(left: 30,top: 20,),
                        child: RichText(text: TextSpan(
                          children: [
                               TextSpan(text: 'Upto 40 % OFF *\n\n',
                               style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),) ,
                          TextSpan(
                            text: 'Discounts that feels \n like a vacation.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            )
                          )
                          
                          ]
                        ),
                        
                        ),
                        )
                    ]))),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Hotel near you',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                  
                      TextButton(onPressed: (){}, child: Text('See All'))
                    ],
                  ),
                )
            ],
          ),
        ),
      )
    );
  }
}