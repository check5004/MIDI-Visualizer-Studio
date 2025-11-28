// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'midi_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MidiEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MidiEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MidiEvent()';
}


}

/// @nodoc
class $MidiEventCopyWith<$Res>  {
$MidiEventCopyWith(MidiEvent _, $Res Function(MidiEvent) __);
}


/// Adds pattern-matching-related methods to [MidiEvent].
extension MidiEventPatterns on MidiEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ScanDevices value)?  scanDevices,TResult Function( ConnectDevice value)?  connectDevice,TResult Function( DisconnectDevice value)?  disconnectDevice,TResult Function( MidiMessageReceived value)?  midiMessageReceived,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ScanDevices() when scanDevices != null:
return scanDevices(_that);case ConnectDevice() when connectDevice != null:
return connectDevice(_that);case DisconnectDevice() when disconnectDevice != null:
return disconnectDevice(_that);case MidiMessageReceived() when midiMessageReceived != null:
return midiMessageReceived(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ScanDevices value)  scanDevices,required TResult Function( ConnectDevice value)  connectDevice,required TResult Function( DisconnectDevice value)  disconnectDevice,required TResult Function( MidiMessageReceived value)  midiMessageReceived,}){
final _that = this;
switch (_that) {
case ScanDevices():
return scanDevices(_that);case ConnectDevice():
return connectDevice(_that);case DisconnectDevice():
return disconnectDevice(_that);case MidiMessageReceived():
return midiMessageReceived(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ScanDevices value)?  scanDevices,TResult? Function( ConnectDevice value)?  connectDevice,TResult? Function( DisconnectDevice value)?  disconnectDevice,TResult? Function( MidiMessageReceived value)?  midiMessageReceived,}){
final _that = this;
switch (_that) {
case ScanDevices() when scanDevices != null:
return scanDevices(_that);case ConnectDevice() when connectDevice != null:
return connectDevice(_that);case DisconnectDevice() when disconnectDevice != null:
return disconnectDevice(_that);case MidiMessageReceived() when midiMessageReceived != null:
return midiMessageReceived(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  scanDevices,TResult Function( MidiDevice device)?  connectDevice,TResult Function( MidiDevice device)?  disconnectDevice,TResult Function( MidiPacket packet)?  midiMessageReceived,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ScanDevices() when scanDevices != null:
return scanDevices();case ConnectDevice() when connectDevice != null:
return connectDevice(_that.device);case DisconnectDevice() when disconnectDevice != null:
return disconnectDevice(_that.device);case MidiMessageReceived() when midiMessageReceived != null:
return midiMessageReceived(_that.packet);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  scanDevices,required TResult Function( MidiDevice device)  connectDevice,required TResult Function( MidiDevice device)  disconnectDevice,required TResult Function( MidiPacket packet)  midiMessageReceived,}) {final _that = this;
switch (_that) {
case ScanDevices():
return scanDevices();case ConnectDevice():
return connectDevice(_that.device);case DisconnectDevice():
return disconnectDevice(_that.device);case MidiMessageReceived():
return midiMessageReceived(_that.packet);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  scanDevices,TResult? Function( MidiDevice device)?  connectDevice,TResult? Function( MidiDevice device)?  disconnectDevice,TResult? Function( MidiPacket packet)?  midiMessageReceived,}) {final _that = this;
switch (_that) {
case ScanDevices() when scanDevices != null:
return scanDevices();case ConnectDevice() when connectDevice != null:
return connectDevice(_that.device);case DisconnectDevice() when disconnectDevice != null:
return disconnectDevice(_that.device);case MidiMessageReceived() when midiMessageReceived != null:
return midiMessageReceived(_that.packet);case _:
  return null;

}
}

}

/// @nodoc


class ScanDevices implements MidiEvent {
  const ScanDevices();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanDevices);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MidiEvent.scanDevices()';
}


}




/// @nodoc


class ConnectDevice implements MidiEvent {
  const ConnectDevice(this.device);
  

 final  MidiDevice device;

/// Create a copy of MidiEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectDeviceCopyWith<ConnectDevice> get copyWith => _$ConnectDeviceCopyWithImpl<ConnectDevice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectDevice&&(identical(other.device, device) || other.device == device));
}


@override
int get hashCode => Object.hash(runtimeType,device);

@override
String toString() {
  return 'MidiEvent.connectDevice(device: $device)';
}


}

/// @nodoc
abstract mixin class $ConnectDeviceCopyWith<$Res> implements $MidiEventCopyWith<$Res> {
  factory $ConnectDeviceCopyWith(ConnectDevice value, $Res Function(ConnectDevice) _then) = _$ConnectDeviceCopyWithImpl;
@useResult
$Res call({
 MidiDevice device
});




}
/// @nodoc
class _$ConnectDeviceCopyWithImpl<$Res>
    implements $ConnectDeviceCopyWith<$Res> {
  _$ConnectDeviceCopyWithImpl(this._self, this._then);

  final ConnectDevice _self;
  final $Res Function(ConnectDevice) _then;

/// Create a copy of MidiEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? device = null,}) {
  return _then(ConnectDevice(
null == device ? _self.device : device // ignore: cast_nullable_to_non_nullable
as MidiDevice,
  ));
}


}

/// @nodoc


class DisconnectDevice implements MidiEvent {
  const DisconnectDevice(this.device);
  

 final  MidiDevice device;

/// Create a copy of MidiEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisconnectDeviceCopyWith<DisconnectDevice> get copyWith => _$DisconnectDeviceCopyWithImpl<DisconnectDevice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisconnectDevice&&(identical(other.device, device) || other.device == device));
}


@override
int get hashCode => Object.hash(runtimeType,device);

@override
String toString() {
  return 'MidiEvent.disconnectDevice(device: $device)';
}


}

/// @nodoc
abstract mixin class $DisconnectDeviceCopyWith<$Res> implements $MidiEventCopyWith<$Res> {
  factory $DisconnectDeviceCopyWith(DisconnectDevice value, $Res Function(DisconnectDevice) _then) = _$DisconnectDeviceCopyWithImpl;
@useResult
$Res call({
 MidiDevice device
});




}
/// @nodoc
class _$DisconnectDeviceCopyWithImpl<$Res>
    implements $DisconnectDeviceCopyWith<$Res> {
  _$DisconnectDeviceCopyWithImpl(this._self, this._then);

  final DisconnectDevice _self;
  final $Res Function(DisconnectDevice) _then;

/// Create a copy of MidiEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? device = null,}) {
  return _then(DisconnectDevice(
null == device ? _self.device : device // ignore: cast_nullable_to_non_nullable
as MidiDevice,
  ));
}


}

/// @nodoc


class MidiMessageReceived implements MidiEvent {
  const MidiMessageReceived(this.packet);
  

 final  MidiPacket packet;

/// Create a copy of MidiEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MidiMessageReceivedCopyWith<MidiMessageReceived> get copyWith => _$MidiMessageReceivedCopyWithImpl<MidiMessageReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MidiMessageReceived&&(identical(other.packet, packet) || other.packet == packet));
}


@override
int get hashCode => Object.hash(runtimeType,packet);

@override
String toString() {
  return 'MidiEvent.midiMessageReceived(packet: $packet)';
}


}

/// @nodoc
abstract mixin class $MidiMessageReceivedCopyWith<$Res> implements $MidiEventCopyWith<$Res> {
  factory $MidiMessageReceivedCopyWith(MidiMessageReceived value, $Res Function(MidiMessageReceived) _then) = _$MidiMessageReceivedCopyWithImpl;
@useResult
$Res call({
 MidiPacket packet
});




}
/// @nodoc
class _$MidiMessageReceivedCopyWithImpl<$Res>
    implements $MidiMessageReceivedCopyWith<$Res> {
  _$MidiMessageReceivedCopyWithImpl(this._self, this._then);

  final MidiMessageReceived _self;
  final $Res Function(MidiMessageReceived) _then;

/// Create a copy of MidiEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? packet = null,}) {
  return _then(MidiMessageReceived(
null == packet ? _self.packet : packet // ignore: cast_nullable_to_non_nullable
as MidiPacket,
  ));
}


}

/// @nodoc
mixin _$MidiState {

 MidiStatus get status; List<MidiDevice> get devices; MidiDevice? get connectedDevice; MidiPacket? get lastPacket; String? get errorMessage;
/// Create a copy of MidiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MidiStateCopyWith<MidiState> get copyWith => _$MidiStateCopyWithImpl<MidiState>(this as MidiState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MidiState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.devices, devices)&&(identical(other.connectedDevice, connectedDevice) || other.connectedDevice == connectedDevice)&&(identical(other.lastPacket, lastPacket) || other.lastPacket == lastPacket)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(devices),connectedDevice,lastPacket,errorMessage);

@override
String toString() {
  return 'MidiState(status: $status, devices: $devices, connectedDevice: $connectedDevice, lastPacket: $lastPacket, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $MidiStateCopyWith<$Res>  {
  factory $MidiStateCopyWith(MidiState value, $Res Function(MidiState) _then) = _$MidiStateCopyWithImpl;
@useResult
$Res call({
 MidiStatus status, List<MidiDevice> devices, MidiDevice? connectedDevice, MidiPacket? lastPacket, String? errorMessage
});




}
/// @nodoc
class _$MidiStateCopyWithImpl<$Res>
    implements $MidiStateCopyWith<$Res> {
  _$MidiStateCopyWithImpl(this._self, this._then);

  final MidiState _self;
  final $Res Function(MidiState) _then;

/// Create a copy of MidiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? devices = null,Object? connectedDevice = freezed,Object? lastPacket = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MidiStatus,devices: null == devices ? _self.devices : devices // ignore: cast_nullable_to_non_nullable
as List<MidiDevice>,connectedDevice: freezed == connectedDevice ? _self.connectedDevice : connectedDevice // ignore: cast_nullable_to_non_nullable
as MidiDevice?,lastPacket: freezed == lastPacket ? _self.lastPacket : lastPacket // ignore: cast_nullable_to_non_nullable
as MidiPacket?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MidiState].
extension MidiStatePatterns on MidiState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MidiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MidiState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MidiState value)  $default,){
final _that = this;
switch (_that) {
case _MidiState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MidiState value)?  $default,){
final _that = this;
switch (_that) {
case _MidiState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MidiStatus status,  List<MidiDevice> devices,  MidiDevice? connectedDevice,  MidiPacket? lastPacket,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MidiState() when $default != null:
return $default(_that.status,_that.devices,_that.connectedDevice,_that.lastPacket,_that.errorMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MidiStatus status,  List<MidiDevice> devices,  MidiDevice? connectedDevice,  MidiPacket? lastPacket,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _MidiState():
return $default(_that.status,_that.devices,_that.connectedDevice,_that.lastPacket,_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MidiStatus status,  List<MidiDevice> devices,  MidiDevice? connectedDevice,  MidiPacket? lastPacket,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _MidiState() when $default != null:
return $default(_that.status,_that.devices,_that.connectedDevice,_that.lastPacket,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _MidiState implements MidiState {
  const _MidiState({this.status = MidiStatus.initial, final  List<MidiDevice> devices = const [], this.connectedDevice, this.lastPacket, this.errorMessage}): _devices = devices;
  

@override@JsonKey() final  MidiStatus status;
 final  List<MidiDevice> _devices;
@override@JsonKey() List<MidiDevice> get devices {
  if (_devices is EqualUnmodifiableListView) return _devices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_devices);
}

@override final  MidiDevice? connectedDevice;
@override final  MidiPacket? lastPacket;
@override final  String? errorMessage;

/// Create a copy of MidiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MidiStateCopyWith<_MidiState> get copyWith => __$MidiStateCopyWithImpl<_MidiState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MidiState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._devices, _devices)&&(identical(other.connectedDevice, connectedDevice) || other.connectedDevice == connectedDevice)&&(identical(other.lastPacket, lastPacket) || other.lastPacket == lastPacket)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_devices),connectedDevice,lastPacket,errorMessage);

@override
String toString() {
  return 'MidiState(status: $status, devices: $devices, connectedDevice: $connectedDevice, lastPacket: $lastPacket, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$MidiStateCopyWith<$Res> implements $MidiStateCopyWith<$Res> {
  factory _$MidiStateCopyWith(_MidiState value, $Res Function(_MidiState) _then) = __$MidiStateCopyWithImpl;
@override @useResult
$Res call({
 MidiStatus status, List<MidiDevice> devices, MidiDevice? connectedDevice, MidiPacket? lastPacket, String? errorMessage
});




}
/// @nodoc
class __$MidiStateCopyWithImpl<$Res>
    implements _$MidiStateCopyWith<$Res> {
  __$MidiStateCopyWithImpl(this._self, this._then);

  final _MidiState _self;
  final $Res Function(_MidiState) _then;

/// Create a copy of MidiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? devices = null,Object? connectedDevice = freezed,Object? lastPacket = freezed,Object? errorMessage = freezed,}) {
  return _then(_MidiState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MidiStatus,devices: null == devices ? _self._devices : devices // ignore: cast_nullable_to_non_nullable
as List<MidiDevice>,connectedDevice: freezed == connectedDevice ? _self.connectedDevice : connectedDevice // ignore: cast_nullable_to_non_nullable
as MidiDevice?,lastPacket: freezed == lastPacket ? _self.lastPacket : lastPacket // ignore: cast_nullable_to_non_nullable
as MidiPacket?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
