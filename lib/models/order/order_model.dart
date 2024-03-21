import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class OrderModel {
  final String? productName;
  final String? productPrice;
  final String? productImage;
  final double? rating;
  final String? productDescription;
  final String? orderId;
  final String? productId;
  final String? productUuid;
  final DateTime? createdAt;
  final DateTime? deliveredDate;
  final String? uid;
  final String? userName;
  final String? userAddress;
  final String? userPhone;
  final String? userAge;
  final String? userGender;
  final String? userEmail;
  final String? orderStatus;
  final List<dynamic>? reportImages;
  OrderModel({
    this.productName,
    this.productPrice,
    this.productImage,
    this.rating,
    this.productDescription,
    this.orderId,
    this.productId,
    this.productUuid,
    this.createdAt,
    this.deliveredDate,
    this.uid,
    this.userName,
    this.userAddress,
    this.userPhone,
    this.userAge,
    this.userGender,
    this.userEmail,
    this.orderStatus,
    this.reportImages,
  });

  OrderModel copyWith({
    String? productName,
    String? productPrice,
    String? productImage,
    double? rating,
    String? productDescription,
    String? orderId,
    String? productId,
    String? productUuid,
    DateTime? createdAt,
    DateTime? deliveredDate,
    String? uid,
    String? userName,
    String? userAddress,
    String? userPhone,
    String? userAge,
    String? userGender,
    String? userEmail,
    String? orderStatus,
    List<dynamic>? reportImages,
  }) {
    return OrderModel(
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      productImage: productImage ?? this.productImage,
      rating: rating ?? this.rating,
      productDescription: productDescription ?? this.productDescription,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      productUuid: productUuid ?? this.productUuid,
      createdAt: createdAt ?? this.createdAt,
      deliveredDate: deliveredDate ?? this.deliveredDate,
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      userAddress: userAddress ?? this.userAddress,
      userPhone: userPhone ?? this.userPhone,
      userAge: userAge ?? this.userAge,
      userGender: userGender ?? this.userGender,
      userEmail: userEmail ?? this.userEmail,
      orderStatus: orderStatus ?? this.orderStatus,
      reportImages: reportImages ?? this.reportImages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'productPrice': productPrice,
      'productImage': productImage,
      'rating': rating,
      'productDescription': productDescription,
      'orderId': orderId,
      'productId': productId,
      'productUuid': productUuid,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'deliveredDate': deliveredDate?.millisecondsSinceEpoch,
      'uid': uid,
      'userName': userName,
      'userAddress': userAddress,
      'userPhone': userPhone,
      'userAge': userAge,
      'userGender': userGender,
      'userEmail': userEmail,
      'orderStatus': orderStatus,
      'reportImages': reportImages,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
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
      orderId: map['orderId'] != null ? map['orderId'] as String : null,
      productId: map['productId'] != null ? map['productId'] as String : null,
      productUuid:
          map['productUuid'] != null ? map['productUuid'] as String : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      deliveredDate: map['deliveredDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['deliveredDate'] as int)
          : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      userAddress:
          map['userAddress'] != null ? map['userAddress'] as String : null,
      userPhone: map['userPhone'] != null ? map['userPhone'] as String : null,
      userAge: map['userAge'] != null ? map['userAge'] as String : null,
      userGender:
          map['userGender'] != null ? map['userGender'] as String : null,
      userEmail: map['userEmail'] != null ? map['userEmail'] as String : null,
      orderStatus:
          map['orderStatus'] != null ? map['orderStatus'] as String : null,
      reportImages: map['reportImages'] != null
          ? List<dynamic>.from((map['reportImages'] as List<dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(productName: $productName, productPrice: $productPrice, productImage: $productImage, rating: $rating, productDescription: $productDescription, orderId: $orderId, productId: $productId, productUuid: $productUuid, createdAt: $createdAt, deliveredDate: $deliveredDate, uid: $uid, userName: $userName, userAddress: $userAddress, userPhone: $userPhone, userAge: $userAge, userGender: $userGender, userEmail: $userEmail, orderStatus: $orderStatus, reportImages: $reportImages)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.productName == productName &&
        other.productPrice == productPrice &&
        other.productImage == productImage &&
        other.rating == rating &&
        other.productDescription == productDescription &&
        other.orderId == orderId &&
        other.productId == productId &&
        other.productUuid == productUuid &&
        other.createdAt == createdAt &&
        other.deliveredDate == deliveredDate &&
        other.uid == uid &&
        other.userName == userName &&
        other.userAddress == userAddress &&
        other.userPhone == userPhone &&
        other.userAge == userAge &&
        other.userGender == userGender &&
        other.userEmail == userEmail &&
        other.orderStatus == orderStatus &&
        listEquals(other.reportImages, reportImages);
  }

  @override
  int get hashCode {
    return productName.hashCode ^
        productPrice.hashCode ^
        productImage.hashCode ^
        rating.hashCode ^
        productDescription.hashCode ^
        orderId.hashCode ^
        productId.hashCode ^
        productUuid.hashCode ^
        createdAt.hashCode ^
        deliveredDate.hashCode ^
        uid.hashCode ^
        userName.hashCode ^
        userAddress.hashCode ^
        userPhone.hashCode ^
        userAge.hashCode ^
        userGender.hashCode ^
        userEmail.hashCode ^
        orderStatus.hashCode ^
        reportImages.hashCode;
  }
}
