// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Failure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) databaseError,
    required TResult Function() locationPermissionDenied,
    required TResult Function() locationPermissionPermanentlyDenied,
    required TResult Function() locationServiceDisabled,
    required TResult Function(String message) unknownError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? databaseError,
    TResult? Function()? locationPermissionDenied,
    TResult? Function()? locationPermissionPermanentlyDenied,
    TResult? Function()? locationServiceDisabled,
    TResult? Function(String message)? unknownError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? databaseError,
    TResult Function()? locationPermissionDenied,
    TResult Function()? locationPermissionPermanentlyDenied,
    TResult Function()? locationServiceDisabled,
    TResult Function(String message)? unknownError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DatabaseError value) databaseError,
    required TResult Function(_LocationPermissionDenied value)
    locationPermissionDenied,
    required TResult Function(_LocationPermissionPermanentlyDenied value)
    locationPermissionPermanentlyDenied,
    required TResult Function(_LocationServiceDisabled value)
    locationServiceDisabled,
    required TResult Function(_UnknownError value) unknownError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DatabaseError value)? databaseError,
    TResult? Function(_LocationPermissionDenied value)?
    locationPermissionDenied,
    TResult? Function(_LocationPermissionPermanentlyDenied value)?
    locationPermissionPermanentlyDenied,
    TResult? Function(_LocationServiceDisabled value)? locationServiceDisabled,
    TResult? Function(_UnknownError value)? unknownError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DatabaseError value)? databaseError,
    TResult Function(_LocationPermissionDenied value)? locationPermissionDenied,
    TResult Function(_LocationPermissionPermanentlyDenied value)?
    locationPermissionPermanentlyDenied,
    TResult Function(_LocationServiceDisabled value)? locationServiceDisabled,
    TResult Function(_UnknownError value)? unknownError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$DatabaseErrorImplCopyWith<$Res> {
  factory _$$DatabaseErrorImplCopyWith(
    _$DatabaseErrorImpl value,
    $Res Function(_$DatabaseErrorImpl) then,
  ) = __$$DatabaseErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$DatabaseErrorImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$DatabaseErrorImpl>
    implements _$$DatabaseErrorImplCopyWith<$Res> {
  __$$DatabaseErrorImplCopyWithImpl(
    _$DatabaseErrorImpl _value,
    $Res Function(_$DatabaseErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$DatabaseErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DatabaseErrorImpl implements _DatabaseError {
  const _$DatabaseErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.databaseError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatabaseErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DatabaseErrorImplCopyWith<_$DatabaseErrorImpl> get copyWith =>
      __$$DatabaseErrorImplCopyWithImpl<_$DatabaseErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) databaseError,
    required TResult Function() locationPermissionDenied,
    required TResult Function() locationPermissionPermanentlyDenied,
    required TResult Function() locationServiceDisabled,
    required TResult Function(String message) unknownError,
  }) {
    return databaseError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? databaseError,
    TResult? Function()? locationPermissionDenied,
    TResult? Function()? locationPermissionPermanentlyDenied,
    TResult? Function()? locationServiceDisabled,
    TResult? Function(String message)? unknownError,
  }) {
    return databaseError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? databaseError,
    TResult Function()? locationPermissionDenied,
    TResult Function()? locationPermissionPermanentlyDenied,
    TResult Function()? locationServiceDisabled,
    TResult Function(String message)? unknownError,
    required TResult orElse(),
  }) {
    if (databaseError != null) {
      return databaseError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DatabaseError value) databaseError,
    required TResult Function(_LocationPermissionDenied value)
    locationPermissionDenied,
    required TResult Function(_LocationPermissionPermanentlyDenied value)
    locationPermissionPermanentlyDenied,
    required TResult Function(_LocationServiceDisabled value)
    locationServiceDisabled,
    required TResult Function(_UnknownError value) unknownError,
  }) {
    return databaseError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DatabaseError value)? databaseError,
    TResult? Function(_LocationPermissionDenied value)?
    locationPermissionDenied,
    TResult? Function(_LocationPermissionPermanentlyDenied value)?
    locationPermissionPermanentlyDenied,
    TResult? Function(_LocationServiceDisabled value)? locationServiceDisabled,
    TResult? Function(_UnknownError value)? unknownError,
  }) {
    return databaseError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DatabaseError value)? databaseError,
    TResult Function(_LocationPermissionDenied value)? locationPermissionDenied,
    TResult Function(_LocationPermissionPermanentlyDenied value)?
    locationPermissionPermanentlyDenied,
    TResult Function(_LocationServiceDisabled value)? locationServiceDisabled,
    TResult Function(_UnknownError value)? unknownError,
    required TResult orElse(),
  }) {
    if (databaseError != null) {
      return databaseError(this);
    }
    return orElse();
  }
}

abstract class _DatabaseError implements Failure {
  const factory _DatabaseError(final String message) = _$DatabaseErrorImpl;

  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DatabaseErrorImplCopyWith<_$DatabaseErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LocationPermissionDeniedImplCopyWith<$Res> {
  factory _$$LocationPermissionDeniedImplCopyWith(
    _$LocationPermissionDeniedImpl value,
    $Res Function(_$LocationPermissionDeniedImpl) then,
  ) = __$$LocationPermissionDeniedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LocationPermissionDeniedImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$LocationPermissionDeniedImpl>
    implements _$$LocationPermissionDeniedImplCopyWith<$Res> {
  __$$LocationPermissionDeniedImplCopyWithImpl(
    _$LocationPermissionDeniedImpl _value,
    $Res Function(_$LocationPermissionDeniedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LocationPermissionDeniedImpl implements _LocationPermissionDenied {
  const _$LocationPermissionDeniedImpl();

  @override
  String toString() {
    return 'Failure.locationPermissionDenied()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationPermissionDeniedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) databaseError,
    required TResult Function() locationPermissionDenied,
    required TResult Function() locationPermissionPermanentlyDenied,
    required TResult Function() locationServiceDisabled,
    required TResult Function(String message) unknownError,
  }) {
    return locationPermissionDenied();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? databaseError,
    TResult? Function()? locationPermissionDenied,
    TResult? Function()? locationPermissionPermanentlyDenied,
    TResult? Function()? locationServiceDisabled,
    TResult? Function(String message)? unknownError,
  }) {
    return locationPermissionDenied?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? databaseError,
    TResult Function()? locationPermissionDenied,
    TResult Function()? locationPermissionPermanentlyDenied,
    TResult Function()? locationServiceDisabled,
    TResult Function(String message)? unknownError,
    required TResult orElse(),
  }) {
    if (locationPermissionDenied != null) {
      return locationPermissionDenied();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DatabaseError value) databaseError,
    required TResult Function(_LocationPermissionDenied value)
    locationPermissionDenied,
    required TResult Function(_LocationPermissionPermanentlyDenied value)
    locationPermissionPermanentlyDenied,
    required TResult Function(_LocationServiceDisabled value)
    locationServiceDisabled,
    required TResult Function(_UnknownError value) unknownError,
  }) {
    return locationPermissionDenied(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DatabaseError value)? databaseError,
    TResult? Function(_LocationPermissionDenied value)?
    locationPermissionDenied,
    TResult? Function(_LocationPermissionPermanentlyDenied value)?
    locationPermissionPermanentlyDenied,
    TResult? Function(_LocationServiceDisabled value)? locationServiceDisabled,
    TResult? Function(_UnknownError value)? unknownError,
  }) {
    return locationPermissionDenied?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DatabaseError value)? databaseError,
    TResult Function(_LocationPermissionDenied value)? locationPermissionDenied,
    TResult Function(_LocationPermissionPermanentlyDenied value)?
    locationPermissionPermanentlyDenied,
    TResult Function(_LocationServiceDisabled value)? locationServiceDisabled,
    TResult Function(_UnknownError value)? unknownError,
    required TResult orElse(),
  }) {
    if (locationPermissionDenied != null) {
      return locationPermissionDenied(this);
    }
    return orElse();
  }
}

abstract class _LocationPermissionDenied implements Failure {
  const factory _LocationPermissionDenied() = _$LocationPermissionDeniedImpl;
}

/// @nodoc
abstract class _$$LocationPermissionPermanentlyDeniedImplCopyWith<$Res> {
  factory _$$LocationPermissionPermanentlyDeniedImplCopyWith(
    _$LocationPermissionPermanentlyDeniedImpl value,
    $Res Function(_$LocationPermissionPermanentlyDeniedImpl) then,
  ) = __$$LocationPermissionPermanentlyDeniedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LocationPermissionPermanentlyDeniedImplCopyWithImpl<$Res>
    extends
        _$FailureCopyWithImpl<$Res, _$LocationPermissionPermanentlyDeniedImpl>
    implements _$$LocationPermissionPermanentlyDeniedImplCopyWith<$Res> {
  __$$LocationPermissionPermanentlyDeniedImplCopyWithImpl(
    _$LocationPermissionPermanentlyDeniedImpl _value,
    $Res Function(_$LocationPermissionPermanentlyDeniedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LocationPermissionPermanentlyDeniedImpl
    implements _LocationPermissionPermanentlyDenied {
  const _$LocationPermissionPermanentlyDeniedImpl();

  @override
  String toString() {
    return 'Failure.locationPermissionPermanentlyDenied()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationPermissionPermanentlyDeniedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) databaseError,
    required TResult Function() locationPermissionDenied,
    required TResult Function() locationPermissionPermanentlyDenied,
    required TResult Function() locationServiceDisabled,
    required TResult Function(String message) unknownError,
  }) {
    return locationPermissionPermanentlyDenied();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? databaseError,
    TResult? Function()? locationPermissionDenied,
    TResult? Function()? locationPermissionPermanentlyDenied,
    TResult? Function()? locationServiceDisabled,
    TResult? Function(String message)? unknownError,
  }) {
    return locationPermissionPermanentlyDenied?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? databaseError,
    TResult Function()? locationPermissionDenied,
    TResult Function()? locationPermissionPermanentlyDenied,
    TResult Function()? locationServiceDisabled,
    TResult Function(String message)? unknownError,
    required TResult orElse(),
  }) {
    if (locationPermissionPermanentlyDenied != null) {
      return locationPermissionPermanentlyDenied();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DatabaseError value) databaseError,
    required TResult Function(_LocationPermissionDenied value)
    locationPermissionDenied,
    required TResult Function(_LocationPermissionPermanentlyDenied value)
    locationPermissionPermanentlyDenied,
    required TResult Function(_LocationServiceDisabled value)
    locationServiceDisabled,
    required TResult Function(_UnknownError value) unknownError,
  }) {
    return locationPermissionPermanentlyDenied(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DatabaseError value)? databaseError,
    TResult? Function(_LocationPermissionDenied value)?
    locationPermissionDenied,
    TResult? Function(_LocationPermissionPermanentlyDenied value)?
    locationPermissionPermanentlyDenied,
    TResult? Function(_LocationServiceDisabled value)? locationServiceDisabled,
    TResult? Function(_UnknownError value)? unknownError,
  }) {
    return locationPermissionPermanentlyDenied?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DatabaseError value)? databaseError,
    TResult Function(_LocationPermissionDenied value)? locationPermissionDenied,
    TResult Function(_LocationPermissionPermanentlyDenied value)?
    locationPermissionPermanentlyDenied,
    TResult Function(_LocationServiceDisabled value)? locationServiceDisabled,
    TResult Function(_UnknownError value)? unknownError,
    required TResult orElse(),
  }) {
    if (locationPermissionPermanentlyDenied != null) {
      return locationPermissionPermanentlyDenied(this);
    }
    return orElse();
  }
}

abstract class _LocationPermissionPermanentlyDenied implements Failure {
  const factory _LocationPermissionPermanentlyDenied() =
      _$LocationPermissionPermanentlyDeniedImpl;
}

/// @nodoc
abstract class _$$LocationServiceDisabledImplCopyWith<$Res> {
  factory _$$LocationServiceDisabledImplCopyWith(
    _$LocationServiceDisabledImpl value,
    $Res Function(_$LocationServiceDisabledImpl) then,
  ) = __$$LocationServiceDisabledImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LocationServiceDisabledImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$LocationServiceDisabledImpl>
    implements _$$LocationServiceDisabledImplCopyWith<$Res> {
  __$$LocationServiceDisabledImplCopyWithImpl(
    _$LocationServiceDisabledImpl _value,
    $Res Function(_$LocationServiceDisabledImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LocationServiceDisabledImpl implements _LocationServiceDisabled {
  const _$LocationServiceDisabledImpl();

  @override
  String toString() {
    return 'Failure.locationServiceDisabled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationServiceDisabledImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) databaseError,
    required TResult Function() locationPermissionDenied,
    required TResult Function() locationPermissionPermanentlyDenied,
    required TResult Function() locationServiceDisabled,
    required TResult Function(String message) unknownError,
  }) {
    return locationServiceDisabled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? databaseError,
    TResult? Function()? locationPermissionDenied,
    TResult? Function()? locationPermissionPermanentlyDenied,
    TResult? Function()? locationServiceDisabled,
    TResult? Function(String message)? unknownError,
  }) {
    return locationServiceDisabled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? databaseError,
    TResult Function()? locationPermissionDenied,
    TResult Function()? locationPermissionPermanentlyDenied,
    TResult Function()? locationServiceDisabled,
    TResult Function(String message)? unknownError,
    required TResult orElse(),
  }) {
    if (locationServiceDisabled != null) {
      return locationServiceDisabled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DatabaseError value) databaseError,
    required TResult Function(_LocationPermissionDenied value)
    locationPermissionDenied,
    required TResult Function(_LocationPermissionPermanentlyDenied value)
    locationPermissionPermanentlyDenied,
    required TResult Function(_LocationServiceDisabled value)
    locationServiceDisabled,
    required TResult Function(_UnknownError value) unknownError,
  }) {
    return locationServiceDisabled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DatabaseError value)? databaseError,
    TResult? Function(_LocationPermissionDenied value)?
    locationPermissionDenied,
    TResult? Function(_LocationPermissionPermanentlyDenied value)?
    locationPermissionPermanentlyDenied,
    TResult? Function(_LocationServiceDisabled value)? locationServiceDisabled,
    TResult? Function(_UnknownError value)? unknownError,
  }) {
    return locationServiceDisabled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DatabaseError value)? databaseError,
    TResult Function(_LocationPermissionDenied value)? locationPermissionDenied,
    TResult Function(_LocationPermissionPermanentlyDenied value)?
    locationPermissionPermanentlyDenied,
    TResult Function(_LocationServiceDisabled value)? locationServiceDisabled,
    TResult Function(_UnknownError value)? unknownError,
    required TResult orElse(),
  }) {
    if (locationServiceDisabled != null) {
      return locationServiceDisabled(this);
    }
    return orElse();
  }
}

abstract class _LocationServiceDisabled implements Failure {
  const factory _LocationServiceDisabled() = _$LocationServiceDisabledImpl;
}

/// @nodoc
abstract class _$$UnknownErrorImplCopyWith<$Res> {
  factory _$$UnknownErrorImplCopyWith(
    _$UnknownErrorImpl value,
    $Res Function(_$UnknownErrorImpl) then,
  ) = __$$UnknownErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UnknownErrorImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UnknownErrorImpl>
    implements _$$UnknownErrorImplCopyWith<$Res> {
  __$$UnknownErrorImplCopyWithImpl(
    _$UnknownErrorImpl _value,
    $Res Function(_$UnknownErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$UnknownErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UnknownErrorImpl implements _UnknownError {
  const _$UnknownErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.unknownError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownErrorImplCopyWith<_$UnknownErrorImpl> get copyWith =>
      __$$UnknownErrorImplCopyWithImpl<_$UnknownErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) databaseError,
    required TResult Function() locationPermissionDenied,
    required TResult Function() locationPermissionPermanentlyDenied,
    required TResult Function() locationServiceDisabled,
    required TResult Function(String message) unknownError,
  }) {
    return unknownError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? databaseError,
    TResult? Function()? locationPermissionDenied,
    TResult? Function()? locationPermissionPermanentlyDenied,
    TResult? Function()? locationServiceDisabled,
    TResult? Function(String message)? unknownError,
  }) {
    return unknownError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? databaseError,
    TResult Function()? locationPermissionDenied,
    TResult Function()? locationPermissionPermanentlyDenied,
    TResult Function()? locationServiceDisabled,
    TResult Function(String message)? unknownError,
    required TResult orElse(),
  }) {
    if (unknownError != null) {
      return unknownError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DatabaseError value) databaseError,
    required TResult Function(_LocationPermissionDenied value)
    locationPermissionDenied,
    required TResult Function(_LocationPermissionPermanentlyDenied value)
    locationPermissionPermanentlyDenied,
    required TResult Function(_LocationServiceDisabled value)
    locationServiceDisabled,
    required TResult Function(_UnknownError value) unknownError,
  }) {
    return unknownError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DatabaseError value)? databaseError,
    TResult? Function(_LocationPermissionDenied value)?
    locationPermissionDenied,
    TResult? Function(_LocationPermissionPermanentlyDenied value)?
    locationPermissionPermanentlyDenied,
    TResult? Function(_LocationServiceDisabled value)? locationServiceDisabled,
    TResult? Function(_UnknownError value)? unknownError,
  }) {
    return unknownError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DatabaseError value)? databaseError,
    TResult Function(_LocationPermissionDenied value)? locationPermissionDenied,
    TResult Function(_LocationPermissionPermanentlyDenied value)?
    locationPermissionPermanentlyDenied,
    TResult Function(_LocationServiceDisabled value)? locationServiceDisabled,
    TResult Function(_UnknownError value)? unknownError,
    required TResult orElse(),
  }) {
    if (unknownError != null) {
      return unknownError(this);
    }
    return orElse();
  }
}

abstract class _UnknownError implements Failure {
  const factory _UnknownError(final String message) = _$UnknownErrorImpl;

  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownErrorImplCopyWith<_$UnknownErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
