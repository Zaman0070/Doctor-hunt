// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class UserModel {
  final String uid;
  final String name;
  final String email;
  final DateTime createdAt;
  final String profileImage;
  final String fcmToken;
  final bool isOnline;
  final String isType;
  final String id;
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.profileImage,
    required this.fcmToken,
    required this.isOnline,
    required this.isType,
    required this.id,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    DateTime? createdAt,
    String? profileImage,
    String? fcmToken,
    bool? isOnline,
    String? isType,
    String? id,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      profileImage: profileImage ?? this.profileImage,
      fcmToken: fcmToken ?? this.fcmToken,
      isOnline: isOnline ?? this.isOnline,
      isType: isType ?? this.isType,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'profileImage': profileImage,
      'fcmToken': fcmToken,
      'isOnline': isOnline,
      'isType': isType,
      'id': id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      profileImage: map['profileImage'] as String,
      fcmToken: map['fcmToken'] as String,
      isOnline: map['isOnline'] as bool,
      isType: map['isType'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, createdAt: $createdAt, profileImage: $profileImage, fcmToken: $fcmToken, isOnline: $isOnline, isType: $isType, id: $id)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.name == name &&
      other.email == email &&
      other.createdAt == createdAt &&
      other.profileImage == profileImage &&
      other.fcmToken == fcmToken &&
      other.isOnline == isOnline &&
      other.isType == isType &&
      other.id == id;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      name.hashCode ^
      email.hashCode ^
      createdAt.hashCode ^
      profileImage.hashCode ^
      fcmToken.hashCode ^
      isOnline.hashCode ^
      isType.hashCode ^
      id.hashCode;
  }
}
