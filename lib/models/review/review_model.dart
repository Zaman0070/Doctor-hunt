// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReviewModel {
  final String? id;
  final String? productId;
  final String? review;
  final double? rating;
  final DateTime? createdAt;
  final String? userName;
  final String? userImage;
  final String? uid;
  ReviewModel({
    this.id,
    this.productId,
    this.review,
    this.rating,
    this.createdAt,
    this.userName,
    this.userImage,
    this.uid,
  });

  ReviewModel copyWith({
    String? id,
    String? productId,
    String? review,
    double? rating,
    DateTime? createdAt,
    String? userName,
    String? userImage,
    String? uid,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      review: review ?? this.review,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'review': review,
      'rating': rating,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'userName': userName,
      'userImage': userImage,
      'uid': uid,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      id: map['id'] != null ? map['id'] as String : null,
      productId: map['productId'] != null ? map['productId'] as String : null,
      review: map['review'] != null ? map['review'] as String : null,
      rating: map['rating'] != null ? map['rating'] as double : null,
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int) : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      userImage: map['userImage'] != null ? map['userImage'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) => ReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReviewModel(id: $id, productId: $productId, review: $review, rating: $rating, createdAt: $createdAt, userName: $userName, userImage: $userImage, uid: $uid)';
  }

  @override
  bool operator ==(covariant ReviewModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.productId == productId &&
      other.review == review &&
      other.rating == rating &&
      other.createdAt == createdAt &&
      other.userName == userName &&
      other.userImage == userImage &&
      other.uid == uid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      productId.hashCode ^
      review.hashCode ^
      rating.hashCode ^
      createdAt.hashCode ^
      userName.hashCode ^
      userImage.hashCode ^
      uid.hashCode;
  }
}
