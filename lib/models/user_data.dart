// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.freezed.dart';
part 'user_data.g.dart';

@freezed
abstract class UserData implements _$UserData {
  const factory UserData({
    @Default('Unknown') String userName,
    @Default('Unknown') String userEmail,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
  const UserData._();

  static UserData? fromDocument(DocumentSnapshot document) {
    if (document == null || document.data == null) return null;
    return UserData(
      userName: document.get('Name').toString(),
      userEmail: document.get('Email').toString(),
    );
  }
}
