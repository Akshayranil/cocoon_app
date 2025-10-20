part of 'payment_bloc.dart';

abstract class PaymentEvent {}

class InitializePayment extends PaymentEvent {}

class StartPayment extends PaymentEvent {
  final String apiKey;
  final double amount;
  final String name;
  final String description;
  final String contact;
  final String email;

  StartPayment({
    required this.apiKey,
    required this.amount,
    required this.name,
    required this.description,
    required this.contact,
    required this.email,
  });
}

class PaymentSuccess extends PaymentEvent {
  final PaymentSuccessResponse response;
  PaymentSuccess(this.response);
}

class PaymentError extends PaymentEvent {
  final PaymentFailureResponse response;
  PaymentError(this.response);
}
