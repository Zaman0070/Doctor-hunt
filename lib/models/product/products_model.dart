// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductModel {
  final String? productName;
  final String? productPrice;
  final String? productImage;
  final double? rating;
  final String? productDescription;
  final String? productId;
  final DateTime? createdAt;
  final List<dynamic>? likes;
  final String? uid;
  ProductModel({
    this.productName,
    this.productPrice,
    this.productImage,
    this.rating,
    this.productDescription,
    this.productId,
    this.createdAt,
    this.likes,
    this.uid,
  });

  ProductModel copyWith({
    String? productName,
    String? productPrice,
    String? productImage,
    double? rating,
    String? productDescription,
    String? productId,
    DateTime? createdAt,
    List<dynamic>? likes,
    String? uid,
  }) {
    return ProductModel(
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      productImage: productImage ?? this.productImage,
      rating: rating ?? this.rating,
      productDescription: productDescription ?? this.productDescription,
      productId: productId ?? this.productId,
      createdAt: createdAt ?? this.createdAt,
      likes: likes ?? this.likes,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'productPrice': productPrice,
      'productImage': productImage,
      'rating': rating,
      'productDescription': productDescription,
      'productId': productId,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'likes': likes,
      'uid': uid,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productName:
          map['productName'] != null ? map['productName'] as String : null,
      productPrice:
          map['productPrice'] != null ? map['productPrice'] as String : null,
      productImage:
          map['productImage'] != null ? map['productImage'] as String : null,
      rating: map['rating'] != null ? (map['rating'] as num).toDouble() : null,
      productDescription: map['productDescription'] != null
          ? map['productDescription'] as String
          : null,
      productId: map['productId'] != null ? map['productId'] as String : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      likes: map['likes'] != null
          ? List<dynamic>.from((map['likes'] as List<dynamic>))
          : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(productName: $productName, productPrice: $productPrice, productImage: $productImage, rating: $rating, productDescription: $productDescription, productId: $productId, createdAt: $createdAt, likes: $likes, uid: $uid)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.productName == productName &&
        other.productPrice == productPrice &&
        other.productImage == productImage &&
        other.rating == rating &&
        other.productDescription == productDescription &&
        other.productId == productId &&
        other.createdAt == createdAt &&
        listEquals(other.likes, likes) &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return productName.hashCode ^
        productPrice.hashCode ^
        productImage.hashCode ^
        rating.hashCode ^
        productDescription.hashCode ^
        productId.hashCode ^
        createdAt.hashCode ^
        likes.hashCode ^
        uid.hashCode;
  }
}
