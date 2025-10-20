import 'package:cocoon_app/model/booked_room_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  late Razorpay razorpay;
  BookedRoom? selectedRoom;
  PaymentBloc() : super(PaymentInitial()) {
    on<InitializePayment>(onInitializePayment);
    on<StartPayment>(onStartPayment);
    on<PaymentSuccess>(onPaymentSuccess);
    on<PaymentError>(onPaymentError);
  }

  void onInitializePayment(
    InitializePayment event,
    Emitter<PaymentState> emit,
  ) {
    razorpay = Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (
      PaymentSuccessResponse response,
    ) {
      add(PaymentSuccess(response));
    });
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (
      PaymentFailureResponse response,
    ) {
      add(PaymentError(response));
    });
  }

  void onStartPayment(StartPayment event, Emitter<PaymentState> emit) {
    
    emit(PaymentInProgress());

    var options = {
      'key': event.apiKey,
      'amount': event.amount * 100, // Razorpay uses paise
      'name': event.name,
      'description': event.description,
      'prefill': {'contact': event.contact, 'email': event.email},
    };

    try {
      razorpay.open(options);
    } catch (e) {
      emit(PaymentFailure("Error: $e"));
    }
  }

  void onPaymentSuccess(PaymentSuccess event, Emitter<PaymentState> emit) {
    emit(PaymentSuccessState(event.response.paymentId ?? ''));
  }

  void onPaymentError(PaymentError event, Emitter<PaymentState> emit) {
    emit(PaymentFailure(event.response.message ?? 'Payment failed'));
  }

  @override
  Future<void> close() {
    razorpay.clear();
    return super.close();
  }
}
