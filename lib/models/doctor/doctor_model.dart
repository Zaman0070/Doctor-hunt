// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class DoctorModel {
  final String name;
  final String email;
  final String imageUrl;
  final String speciality;
  final List<dynamic> avaialbleDays;
  final DateTime from;
  final DateTime to;
  final String id;
  final DateTime createdAt;
  final List<dynamic> rating;
  DoctorModel({
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.speciality,
    required this.avaialbleDays,
    required this.from,
    required this.to,
    required this.id,
    required this.createdAt,
    required this.rating,
  });

  DoctorModel copyWith({
    String? name,
    String? email,
    String? imageUrl,
    String? speciality,
    List<dynamic>? avaialbleDays,
    DateTime? from,
    DateTime? to,
    String? id,
    DateTime? createdAt,
    List<dynamic>? rating,
  }) {
    return DoctorModel(
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      speciality: speciality ?? this.speciality,
      avaialbleDays: avaialbleDays ?? this.avaialbleDays,
      from: from ?? this.from,
      to: to ?? this.to,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'speciality': speciality,
      'avaialbleDays': avaialbleDays,
      'from': from.millisecondsSinceEpoch,
      'to': to.millisecondsSinceEpoch,
      'id': id,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'rating': rating,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      name: map['name'] as String,
      email: map['email'] as String,
      imageUrl: map['imageUrl'] as String,
      speciality: map['speciality'] as String,
      avaialbleDays: List<dynamic>.from((map['avaialbleDays'] as List<dynamic>)),
      from: DateTime.fromMillisecondsSinceEpoch(map['from'] as int),
      to: DateTime.fromMillisecondsSinceEpoch(map['to'] as int),
      id: map['id'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      rating: List<dynamic>.from((map['rating'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorModel.fromJson(String source) => DoctorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DoctorModel(name: $name, email: $email, imageUrl: $imageUrl, speciality: $speciality, avaialbleDays: $avaialbleDays, from: $from, to: $to, id: $id, createdAt: $createdAt, rating: $rating)';
  }

  @override
  bool operator ==(covariant DoctorModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.imageUrl == imageUrl &&
      other.speciality == speciality &&
      listEquals(other.avaialbleDays, avaialbleDays) &&
      other.from == from &&
      other.to == to &&
      other.id == id &&
      other.createdAt == createdAt &&
      listEquals(other.rating, rating);
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      imageUrl.hashCode ^
      speciality.hashCode ^
      avaialbleDays.hashCode ^
      from.hashCode ^
      to.hashCode ^
      id.hashCode ^
      createdAt.hashCode ^
      rating.hashCode;
  }
}
