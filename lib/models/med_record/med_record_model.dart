// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class MedRecordModel {
  final String? id;
  final String userName;
  final List<dynamic>? recImageUrl;
  final DateTime recCreatedOn;
  final String recType;
  final String doctorUid;
  final String doctorName;
  final String uid;
  final DateTime createdAt;
  MedRecordModel({
    this.id,
    required this.userName,
    this.recImageUrl,
    required this.recCreatedOn,
    required this.recType,
    required this.doctorUid,
    required this.doctorName,
    required this.uid,
    required this.createdAt,
  });

  MedRecordModel copyWith({
    String? id,
    String? userName,
    List<dynamic>? recImageUrl,
    DateTime? recCreatedOn,
    String? recType,
    String? doctorUid,
    String? doctorName,
    String? uid,
    DateTime? createdAt,
  }) {
    return MedRecordModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      recImageUrl: recImageUrl ?? this.recImageUrl,
      recCreatedOn: recCreatedOn ?? this.recCreatedOn,
      recType: recType ?? this.recType,
      doctorUid: doctorUid ?? this.doctorUid,
      doctorName: doctorName ?? this.doctorName,
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'recImageUrl': recImageUrl,
      'recCreatedOn': recCreatedOn.millisecondsSinceEpoch,
      'recType': recType,
      'doctorUid': doctorUid,
      'doctorName': doctorName,
      'uid': uid,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory MedRecordModel.fromMap(Map<String, dynamic> map) {
    return MedRecordModel(
      id: map['id'] != null ? map['id'] as String : null,
      userName: map['userName'] as String,
      recImageUrl: map['recImageUrl'] != null ? List<dynamic>.from((map['recImageUrl'] as List<dynamic>) ): null,
      recCreatedOn: DateTime.fromMillisecondsSinceEpoch(map['recCreatedOn'] as int),
      recType: map['recType'] as String,
      doctorUid: map['doctorUid'] as String,
      doctorName: map['doctorName'] as String,
      uid: map['uid'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory MedRecordModel.fromJson(String source) => MedRecordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MedRecordModel(id: $id, userName: $userName, recImageUrl: $recImageUrl, recCreatedOn: $recCreatedOn, recType: $recType, doctorUid: $doctorUid, doctorName: $doctorName, uid: $uid, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant MedRecordModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.userName == userName &&
      listEquals(other.recImageUrl, recImageUrl) &&
      other.recCreatedOn == recCreatedOn &&
      other.recType == recType &&
      other.doctorUid == doctorUid &&
      other.doctorName == doctorName &&
      other.uid == uid &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userName.hashCode ^
      recImageUrl.hashCode ^
      recCreatedOn.hashCode ^
      recType.hashCode ^
      doctorUid.hashCode ^
      doctorName.hashCode ^
      uid.hashCode ^
      createdAt.hashCode;
  }
}
