class ProfileModel {
  final String uid;
  final String name;
  final String phone;
  final String email;
  final String? image;

  ProfileModel({
    required this.uid,
    required this.name,
    required this.phone,
    required this.email,
    this.image
  });

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'name': name, 'phone': phone, 'email': email,'image':image};
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      image: map['image']
    );
  }
}
