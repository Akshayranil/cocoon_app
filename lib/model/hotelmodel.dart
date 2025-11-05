import 'package:cloud_firestore/cloud_firestore.dart';

class Hotel {
  final String id;
  final String type;
  final String name;
  final String booking;
  final String phonenumber;
  final String email;
  final List<String> facilities;
  final String pan;
  final String gst;
  final String propertyinformation;
  final String isOwnedorLeased;
  final String haveRegistration;
  final String document;
  final String status;
  final DateTime? createdAt;
  final List<String> hotelimages;
  final double rating;
  final String price;
  final int reviewCount;

  Hotel({
    required this.id,
    required this.type,
    required this.name,
    required this.booking,
    required this.phonenumber,
    required this.email,
    required this.facilities,
    required this.pan,
    required this.gst,
    required this.propertyinformation,
    required this.isOwnedorLeased,
    required this.haveRegistration,
    required this.document,
    required this.status,
    this.createdAt,
    required this.hotelimages,
    this.rating= 0.0,
    required this.price,
    this.reviewCount = 0,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'type': type,
    'name': name,
    'booking': booking,
    'phonenumber': phonenumber,
    'email': email,
    'facilities': facilities,
    'pan': pan,
    'gst': gst,
    'propertyinformation': propertyinformation,
    'isOwnedorLeased': isOwnedorLeased,
    'haveRegistration': haveRegistration,
    'document': document,
    'status': status,
    'createdAt': createdAt,
    'hotelimages': hotelimages,
    'rating': rating,
    'price': price,
    'reviewCount':reviewCount
  };

  factory Hotel.fromMap(Map<String, dynamic> map, String id) {
    return Hotel(
      id: id,
      type: map['type'] ?? '',
      name: map['name'] ?? '',
      booking: map['booking'] ?? '',
      phonenumber: map['phonenumber'] ?? '',
      email: map['email'] ?? '',
      facilities: List<String>.from(map['facilities'] ?? []),
      pan: map['pan'] ?? '',
      gst: map['gst'] ?? '',
      propertyinformation: map['propertyinformation'] ?? '',
      isOwnedorLeased: map['isOwnedorLeased'] ?? '',
      haveRegistration: map['haveRegistration'] ?? '',
      document: map['document'] ?? '',
      status: map['status'] ?? '',
      createdAt: (map['createdAt'] is Timestamp)
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      hotelimages: List<String>.from(map['hotelimages']),
      rating: (map['rating'] ?? 0.0).toDouble(),
      price: (map['price']?.toString() ?? '1600'),
      reviewCount: map['reviewCount']??0,
    );
  }

  Hotel copyWith({
    String? id,
    String? type,
    String? name,
    String? booking,
    String? phonenumber,
    String? email,
    List<String>? facilities,
    String? pan,
    String? gst,
    String? propertyinformation,
    String? isOwnedorLeased,
    String? haveRegistration,
    String? document,
    String? status,
    DateTime? createdAt,
    List<String>? hotelimages,
    double? rating,
    String? price,
    int? reviewCount,
  }) {
    return Hotel(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      booking: booking ?? this.booking,
      phonenumber: phonenumber ?? this.phonenumber,
      email: email ?? this.email,
      facilities: facilities ?? this.facilities,
      pan: pan ?? this.pan,
      gst: gst ?? this.gst,
      propertyinformation: propertyinformation ?? this.propertyinformation,
      isOwnedorLeased: isOwnedorLeased ?? this.isOwnedorLeased,
      haveRegistration: haveRegistration ?? this.haveRegistration,
      document: document ?? this.document,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      hotelimages: hotelimages ?? this.hotelimages,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      reviewCount: reviewCount??this.reviewCount
    );
  }
}
