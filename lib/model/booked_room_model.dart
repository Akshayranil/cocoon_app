class BookedRoom {
  final String id;
  final String hotelName;
  final String location;
  final double price;
  final String imageUrl;
  final String checkInDate;
  final String checkOutDate;
  final int guests;

  BookedRoom({
    required this.id,
    required this.hotelName,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.checkInDate,
    required this.checkOutDate,
    required this.guests,
  });
}
