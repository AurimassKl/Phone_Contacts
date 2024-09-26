// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contacts_data.freezed.dart';
part 'contacts_data.g.dart';

@freezed
abstract class ContactData implements _$ContactData {
  const factory ContactData({
    @Default('Unknown') String contactName,
    @Default('Unknown') String contactNumber,
    @Default('Unknown') String contactUserId,
    @Default('Unknown') String contactImageURL,
  }) = _ContactData;

  factory ContactData.fromJson(Map<String, dynamic> json) =>
      _$ContactDataFromJson(json);
  const ContactData._();

  static ContactData? fromDocument(DocumentSnapshot document) {
    if (document == null || document.data == null) return null;
    return ContactData(
      contactName: document.get('Name').toString(),
      contactNumber: document.get('Number').toString(),
      contactUserId: document.get('UserId').toString(),
      contactImageURL: document.get('ImageURL').toString(),
    );
  }
}
