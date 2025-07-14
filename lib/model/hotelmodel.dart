class Hotel {
  final String id;
  final String name;
  final String location;
  final double price;
  final double rating;
  final String imageUrl;

  Hotel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });

  factory Hotel.fromMap(Map<String, dynamic> data, String documentId) {
    print("Raw Firestore data for $documentId: $data");
    return Hotel(
      id: documentId,
      name: data['Name'] ?? '',
      location: data['Location'] ?? '',
      price: (data['Price'] ?? 0).toDouble(),
      rating: (data['Rating'] ?? 0).toDouble(),
      imageUrl: data['Image'] ?? '',
    );
  }
  
  // Map<String, dynamic> toMap() {
  //   return {
  //     'name': name,
  //     'location': location,
  //     'price': price,
  //     'rating': rating,
  //     'imageUrl': imageUrl,
  //   };
  // }
  
}
