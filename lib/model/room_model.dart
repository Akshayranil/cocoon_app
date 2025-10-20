class Room {
  final String roomId;
  final int area;
  final String type;
  final int size;
  final String extraBedType;
  final int roomPrice;
  final int extraPersons;
  final List<String> aminities;
  final List<String> images;

  Room({
    required this.roomId,
    required this.area,
    required this.type,
    required this.size,
    required this.extraBedType,
    required this.roomPrice,
    required this.extraPersons,
    required this.aminities,
    required this.images,
  });

    Room copyWith({
    String? roomId,
    int? area,
    String? type,
    int? size,
    String? extraBedType,
    int? roomPrice,
    int? extraPersons,
    List<String>? aminities,
    List<String>? images,
  }) {
    return Room(
      roomId: roomId ?? this.roomId,
      area: area ?? this.area,
      type: type ?? this.type,
      size: size ?? this.size,
      extraBedType: extraBedType ?? this.extraBedType,
      roomPrice: roomPrice ?? this.roomPrice,
      extraPersons: extraPersons ?? this.extraPersons,
      aminities: aminities ?? this.aminities,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'roomId':roomId,
      'area': area,
      'type': type,
      'size': size,
      'extrabedtype':extraBedType,
      'roomPrice': roomPrice,
      'extraPersons':extraPersons,
      'aminities': aminities,
      'images': images,
    };
  } 

factory Room.fromMap(Map<String, dynamic> map, String docId) {
  return Room(
    roomId: docId,
    area: (map['area'] is int)
        ? map['area']
        : (map['area'] is double ? (map['area'] as double).toInt() : 0),
    type: map['type']?.toString() ?? '',
    size: (map['size'] is int)
        ? map['size']
        : (map['size'] is double ? (map['size'] as double).toInt() : 0),
    extraBedType: map['extrabedtype']?.toString() ?? '',
    roomPrice: (map['roomPrice'] is int)
        ? map['roomPrice']
        : (map['roomPrice'] is double ? (map['roomPrice'] as double).toInt() : 0),
    extraPersons: (map['extraPersons'] is int)
        ? map['extraPersons']
        : (map['extraPersons'] is double ? (map['extraPersons'] as double).toInt() : 0),
    aminities: (map['aminities'] is List)
        ? List<String>.from(map['aminities'])
        : [],
    images: (map['images'] is List)
        ? List<String>.from(map['images'])
        : [],
  );
}

}

