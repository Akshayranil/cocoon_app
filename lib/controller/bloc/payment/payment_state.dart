part of 'payment_bloc.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentInProgress extends PaymentState {
  
}

class PaymentSuccessState extends PaymentState {
  final String paymentId;
  PaymentSuccessState(this.paymentId);
}

class PaymentFailure extends PaymentState {
  final String message;
  PaymentFailure(this.message);
}
