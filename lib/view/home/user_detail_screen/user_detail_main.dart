// import 'package:cocoon_app/utilities/custom_color.dart';
// import 'package:cocoon_app/view/home/payment_screen/payment_screen_main.dart';
// import 'package:cocoon_app/view/home/user_detail_screen/widgets/user_date_time_field.dart';
// import 'package:cocoon_app/view/home/user_detail_screen/widgets/user_text_field.dart';
// import 'package:flutter/material.dart';

// class UserDetailScreen extends StatelessWidget {
  
//   const UserDetailScreen({super.key});

//   @override
  
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Choose Room'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         backgroundColor: AppColor.primary,
//         foregroundColor: AppColor.secondary,
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Your details',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       buildTextField(
//                         hintText: '+91-9876543210',
//                         labelText: 'Phone Number',
//                       ),
//                       const SizedBox(height: 12),
//                       buildTextField(
//                         hintText: 'alpha.creed@gmail.com',
//                         labelText: 'Email',
//                       ),
//                       const SizedBox(height: 12),
//                       buildTextField(
//                         hintText: 'First name',
//                         labelText: 'First name',
//                       ),
//                       const SizedBox(height: 12),
//                       buildTextField(
//                         hintText: 'Last name',
//                         labelText: 'Last name',
//                       ),
//                       const SizedBox(height: 12),
                     
//                       const SizedBox(height: 12),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(10),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppColor.primary,
//             foregroundColor: AppColor.secondary,
//           ),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => PaymentScreen()),
//             );
//           },
//           child: const Text('Next Step', style: TextStyle(fontSize: 16)),
//         ),
//       ),
//     );
//   }



// }
