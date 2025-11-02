import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocoon_app/model/profile_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http; // 👈 added
import 'dart:convert';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  ProfileBloc() : super(ProfileInitial()) {
    on<SaveProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final uid = auth.currentUser!.uid;

        // ✅ Upload image to Cloudinary
        String? imageUrl;
        if (event.image.isNotEmpty) {
          const cloudName = 'dbmzu0vdn';
          const uploadPreset = 'profile_image';

          final uploadUrl =
              Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");

          final request = http.MultipartRequest("POST", uploadUrl)
            ..fields['upload_preset'] = uploadPreset
            ..files.add(await http.MultipartFile.fromPath('file', event.image));

          final response = await request.send();
          final responseData = await http.Response.fromStream(response);

          if (response.statusCode == 200) {
            final data = json.decode(responseData.body);
            imageUrl = data['secure_url']; // ✅ Cloudinary image URL
          } else {
            throw Exception("Cloudinary upload failed");
          }
        }

        // ✅ Save profile data to Firestore
        final user = ProfileModel(
          uid: uid,
          name: event.name,
          phone: event.phone,
          email: auth.currentUser!.email ?? '',
          image: imageUrl,
        );

        await firestore.collection('users').doc(uid).set(user.toMap());

        emit(ProfileSavedState());
      } catch (e) {
        emit(ProfileErrorState(e.toString()));
      }
    });

    on<PickImageEvent>((event, emit) {
  emit(ProfileImagePickedState(event.image));
});

on<FetchProfileEvent>((event, emit) async {
  emit(ProfileLoadingState());
  try {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(event.uid)
        .get();

    if (doc.exists) {
      emit(ProfileLoadedState(doc.data()!));
    } else {
      emit(ProfileErrorState("Profile not found"));
    }
  } catch (e) {
    emit(ProfileErrorState(e.toString()));
  }
});


  }
}
