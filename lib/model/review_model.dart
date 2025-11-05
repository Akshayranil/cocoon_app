class HotelReviewModel {
  final String id; // Firebase document ID
  final String hotelId; // Hotel reference
  final String userId; // Who posted the review
  final String userName; // Optional for displaying
  final String comment;
  final double rating;
  
  final DateTime createdAt;

  HotelReviewModel({
    required this.id,
    required this.hotelId,
    required this.userId,
    required this.userName,
    required this.comment,
    required this.rating,
    
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'hotelId': hotelId,
      'userId': userId,
      'userName': userName,
      'comment': comment,
      'rating': rating,
      
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory HotelReviewModel.fromMap(String id, Map<String, dynamic> map) {
    return HotelReviewModel(
      id: id,
      hotelId: map['hotelId'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      comment: map['comment'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
