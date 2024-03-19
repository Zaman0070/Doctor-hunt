// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PharmacyInfoModel {
  String pharmacyName;
  String pharmacyAddress;
  String pharmacyPhone;
  String pharmacyId;
  String pharmacyOpenTime;
  String pharmacyCloseTime;
  DateTime? pharmacyCreatedAt;
  PharmacyInfoModel({
    required this.pharmacyName,
    required this.pharmacyAddress,
    required this.pharmacyPhone,
    required this.pharmacyId,
    required this.pharmacyOpenTime,
    required this.pharmacyCloseTime,
    this.pharmacyCreatedAt,
  });

  PharmacyInfoModel copyWith({
    String? pharmacyName,
    String? pharmacyAddress,
    String? pharmacyPhone,
    String? pharmacyId,
    String? pharmacyOpenTime,
    String? pharmacyCloseTime,
    DateTime? pharmacyCreatedAt,
  }) {
    return PharmacyInfoModel(
      pharmacyName: pharmacyName ?? this.pharmacyName,
      pharmacyAddress: pharmacyAddress ?? this.pharmacyAddress,
      pharmacyPhone: pharmacyPhone ?? this.pharmacyPhone,
      pharmacyId: pharmacyId ?? this.pharmacyId,
      pharmacyOpenTime: pharmacyOpenTime ?? this.pharmacyOpenTime,
      pharmacyCloseTime: pharmacyCloseTime ?? this.pharmacyCloseTime,
      pharmacyCreatedAt: pharmacyCreatedAt ?? this.pharmacyCreatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pharmacyName': pharmacyName,
      'pharmacyAddress': pharmacyAddress,
      'pharmacyPhone': pharmacyPhone,
      'pharmacyId': pharmacyId,
      'pharmacyOpenTime': pharmacyOpenTime,
      'pharmacyCloseTime': pharmacyCloseTime,
      'pharmacyCreatedAt': pharmacyCreatedAt?.millisecondsSinceEpoch,
    };
  }

  factory PharmacyInfoModel.fromMap(Map<String, dynamic> map) {
    return PharmacyInfoModel(
      pharmacyName: map['pharmacyName'] as String,
      pharmacyAddress: map['pharmacyAddress'] as String,
      pharmacyPhone: map['pharmacyPhone'] as String,
      pharmacyId: map['pharmacyId'] as String,
      pharmacyOpenTime: map['pharmacyOpenTime'] as String,
      pharmacyCloseTime: map['pharmacyCloseTime'] as String,
      pharmacyCreatedAt: map['pharmacyCreatedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['pharmacyCreatedAt'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PharmacyInfoModel.fromJson(String source) => PharmacyInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PharmacyInfoModel(pharmacyName: $pharmacyName, pharmacyAddress: $pharmacyAddress, pharmacyPhone: $pharmacyPhone, pharmacyId: $pharmacyId, pharmacyOpenTime: $pharmacyOpenTime, pharmacyCloseTime: $pharmacyCloseTime, pharmacyCreatedAt: $pharmacyCreatedAt)';
  }

  @override
  bool operator ==(covariant PharmacyInfoModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.pharmacyName == pharmacyName &&
      other.pharmacyAddress == pharmacyAddress &&
      other.pharmacyPhone == pharmacyPhone &&
      other.pharmacyId == pharmacyId &&
      other.pharmacyOpenTime == pharmacyOpenTime &&
      other.pharmacyCloseTime == pharmacyCloseTime &&
      other.pharmacyCreatedAt == pharmacyCreatedAt;
  }

  @override
  int get hashCode {
    return pharmacyName.hashCode ^
      pharmacyAddress.hashCode ^
      pharmacyPhone.hashCode ^
      pharmacyId.hashCode ^
      pharmacyOpenTime.hashCode ^
      pharmacyCloseTime.hashCode ^
      pharmacyCreatedAt.hashCode;
  }
}
