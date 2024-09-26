// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'contacts_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ContactData _$$_ContactDataFromJson(Map<String, dynamic> json) =>
    _$_ContactData(
      contactName: json['contactName'] as String? ?? 'Unknown',
      contactNumber: json['contactNumber'] as String? ?? 'Unknown',
      contactUserId: json['contactUserId'] as String? ?? 'Unknown',
      contactImageURL: json['contactImageURL'] as String? ?? 'Unknown',
    );

Map<String, dynamic> _$$_ContactDataToJson(_$_ContactData instance) =>
    <String, dynamic>{
      'contactName': instance.contactName,
      'contactNumber': instance.contactNumber,
      'contactUserId': instance.contactUserId,
      'contactImageURL': instance.contactImageURL,
    };
