class BookedRoom {
  final String id;
  final String hotelUid;
  final String hotelName;
  final String location;
  final double price;
  final String imageUrl;
  final String checkInDate;
  final String checkOutDate;
  final int guests;
  final String userId;
  BookedRoom({
    required this.id,
    required this.hotelUid,
    required this.hotelName,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.checkInDate,
    required this.checkOutDate,
    required this.guests,
    required this.userId,
  });

  // factory BookedRoom.fromMap(Map<String, dynamic> data) {
  //   return BookedRoom(
  //     id: data['id'] ?? '',
  //     hotelName: data['hotelName'] ?? '',
  //     location: data['location'] ?? '',
  //     price: (data['price'] ?? 0).toDouble(),
  //     imageUrl: data['imageUrl'] ?? '',
  //     checkInDate: data['checkInDate'] ?? '',
  //     checkOutDate: data['checkOutDate'] ?? '',
  //     guests: data['guests'] ?? 0,
  //     userId: data['userId'] ?? '',
  //   );
  // }
  //   Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'hotelName': hotelName,
  //     'location': location,
  //     'price': price,
  //     'imageUrl': imageUrl,
  //     'checkInDate': checkInDate,
  //     'checkOutDate': checkOutDate,
  //     'guests': guests,
  //     'userId': userId,
  //   };
  // }
}
