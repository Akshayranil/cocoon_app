import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> onRefresh(BuildContext context) async {
  context.read<HotelBloc>().add(FetchHotels());
  await Future.delayed(Duration(milliseconds: 800));
}
