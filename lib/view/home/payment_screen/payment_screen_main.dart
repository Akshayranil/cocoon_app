import 'package:cocoon_app/view/home/payment_screen/payment_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoon_app/controller/bloc/payment/payment_bloc.dart';


class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Make Payment')),
      body: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is PaymentSuccessState) {
            
            // ✅ Navigate to success screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PaymentSuccessScreen(paymentId: state.paymentId,),
              ),
            );
          } else if (state is PaymentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is PaymentInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          return Center(
            child: ElevatedButton(
              
              onPressed: () {
                context.read<PaymentBloc>().add(
                      StartPayment(
                        apiKey: 'rzp_test_RSzOHF1z22r8ph',
                        amount: 500.0,
                        name: 'Cocoon Hotel',
                        description: 'Hotel Booking Payment',
                        contact: '9876543210',
                        email: 'user@gmail.com',
                      ),
                    );
              },
              child: const Text('Pay ₹500'),
            ),
          );
        },
      ),
    );
  }
}
