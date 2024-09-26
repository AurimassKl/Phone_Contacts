// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'contacts_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ContactData _$ContactDataFromJson(Map<String, dynamic> json) {
  return _ContactData.fromJson(json);
}

/// @nodoc
mixin _$ContactData {
  String get contactName => throw _privateConstructorUsedError;
  String get contactNumber => throw _privateConstructorUsedError;
  String get contactUserId => throw _privateConstructorUsedError;
  String get contactImageURL => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContactDataCopyWith<ContactData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactDataCopyWith<$Res> {
  factory $ContactDataCopyWith(
          ContactData value, $Res Function(ContactData) then) =
      _$ContactDataCopyWithImpl<$Res>;
  $Res call(
      {String contactName,
      String contactNumber,
      String contactUserId,
      String contactImageURL});
}

/// @nodoc
class _$ContactDataCopyWithImpl<$Res> implements $ContactDataCopyWith<$Res> {
  _$ContactDataCopyWithImpl(this._value, this._then);

  final ContactData _value;
  // ignore: unused_field
  final $Res Function(ContactData) _then;

  @override
  $Res call({
    Object? contactName = freezed,
    Object? contactNumber = freezed,
    Object? contactUserId = freezed,
    Object? contactImageURL = freezed,
  }) {
    return _then(_value.copyWith(
      contactName: contactName == freezed
          ? _value.contactName
          : contactName // ignore: cast_nullable_to_non_nullable
              as String,
      contactNumber: contactNumber == freezed
          ? _value.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String,
      contactUserId: contactUserId == freezed
          ? _value.contactUserId
          : contactUserId // ignore: cast_nullable_to_non_nullable
              as String,
      contactImageURL: contactImageURL == freezed
          ? _value.contactImageURL
          : contactImageURL // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ContactDataCopyWith<$Res>
    implements $ContactDataCopyWith<$Res> {
  factory _$$_ContactDataCopyWith(
          _$_ContactData value, $Res Function(_$_ContactData) then) =
      __$$_ContactDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {String contactName,
      String contactNumber,
      String contactUserId,
      String contactImageURL});
}

/// @nodoc
class __$$_ContactDataCopyWithImpl<$Res> extends _$ContactDataCopyWithImpl<$Res>
    implements _$$_ContactDataCopyWith<$Res> {
  __$$_ContactDataCopyWithImpl(
      _$_ContactData _value, $Res Function(_$_ContactData) _then)
      : super(_value, (v) => _then(v as _$_ContactData));

  @override
  _$_ContactData get _value => super._value as _$_ContactData;

  @override
  $Res call({
    Object? contactName = freezed,
    Object? contactNumber = freezed,
    Object? contactUserId = freezed,
    Object? contactImageURL = freezed,
  }) {
    return _then(_$_ContactData(
      contactName: contactName == freezed
          ? _value.contactName
          : contactName // ignore: cast_nullable_to_non_nullable
              as String,
      contactNumber: contactNumber == freezed
          ? _value.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String,
      contactUserId: contactUserId == freezed
          ? _value.contactUserId
          : contactUserId // ignore: cast_nullable_to_non_nullable
              as String,
      contactImageURL: contactImageURL == freezed
          ? _value.contactImageURL
          : contactImageURL // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ContactData extends _ContactData {
  const _$_ContactData(
      {this.contactName = 'Unknown',
      this.contactNumber = 'Unknown',
      this.contactUserId = 'Unknown',
      this.contactImageURL = 'Unknown'})
      : super._();

  factory _$_ContactData.fromJson(Map<String, dynamic> json) =>
      _$$_ContactDataFromJson(json);

  @override
  @JsonKey()
  final String contactName;
  @override
  @JsonKey()
  final String contactNumber;
  @override
  @JsonKey()
  final String contactUserId;
  @override
  @JsonKey()
  final String contactImageURL;

  @override
  String toString() {
    return 'ContactData(contactName: $contactName, contactNumber: $contactNumber, contactUserId: $contactUserId, contactImageURL: $contactImageURL)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ContactData &&
            const DeepCollectionEquality()
                .equals(other.contactName, contactName) &&
            const DeepCollectionEquality()
                .equals(other.contactNumber, contactNumber) &&
            const DeepCollectionEquality()
                .equals(other.contactUserId, contactUserId) &&
            const DeepCollectionEquality()
                .equals(other.contactImageURL, contactImageURL));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(contactName),
      const DeepCollectionEquality().hash(contactNumber),
      const DeepCollectionEquality().hash(contactUserId),
      const DeepCollectionEquality().hash(contactImageURL));

  @JsonKey(ignore: true)
  @override
  _$$_ContactDataCopyWith<_$_ContactData> get copyWith =>
      __$$_ContactDataCopyWithImpl<_$_ContactData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ContactDataToJson(
      this,
    );
  }
}

abstract class _ContactData extends ContactData {
  const factory _ContactData(
      {final String contactName,
      final String contactNumber,
      final String contactUserId,
      final String contactImageURL}) = _$_ContactData;
  const _ContactData._() : super._();

  factory _ContactData.fromJson(Map<String, dynamic> json) =
      _$_ContactData.fromJson;

  @override
  String get contactName;
  @override
  String get contactNumber;
  @override
  String get contactUserId;
  @override
  String get contactImageURL;
  @override
  @JsonKey(ignore: true)
  _$$_ContactDataCopyWith<_$_ContactData> get copyWith =>
      throw _privateConstructorUsedError;
}
