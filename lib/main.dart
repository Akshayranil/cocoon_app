import 'package:cocoon_app/controller/bloc/auth/auth_bloc.dart';
import 'package:cocoon_app/controller/bloc/booking/booking_bloc.dart';
import 'package:cocoon_app/controller/bloc/favorites/favorites_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_event.dart';
import 'package:cocoon_app/controller/bloc/payment/payment_bloc.dart';
import 'package:cocoon_app/controller/bloc/room/room_bloc.dart';
import 'package:cocoon_app/firebase_options.dart';
import 'package:cocoon_app/view/onboarding_screen/screen_check_user_logedin.dart';
import 'package:cocoon_app/view/onboarding_screen/screen_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_)=>AuthBloc()),
        BlocProvider<HotelBloc>(create: (_)=>HotelBloc()..add(FetchHotels())),
        BlocProvider<FavoritesBloc>(create: (_)=>FavoritesBloc()),
        BlocProvider<PaymentBloc>(create: (_)=>PaymentBloc()..add(InitializePayment())),
        BlocProvider<RoomBloc>(create: (_)=>RoomBloc()),
        BlocProvider<BookingBloc>(create: (_)=>BookingBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), 
        ),
        home: CheckUserScreen(),
      ),
    );
  }
}
