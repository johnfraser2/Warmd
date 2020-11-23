// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$NavStateTearOff {
  const _$NavStateTearOff();

// ignore: unused_element
  _NavState call(
      {bool splashScreenSeen = false,
      int onboardingStepsNum = 0,
      bool showAdvicesScreen = false,
      bool showClimateChangeScreen = false,
      bool showClimateChangeScreenFromActions = false,
      bool showAboutScreen = false,
      int questionnaireStepsNum = 0}) {
    return _NavState(
      splashScreenSeen: splashScreenSeen,
      onboardingStepsNum: onboardingStepsNum,
      showAdvicesScreen: showAdvicesScreen,
      showClimateChangeScreen: showClimateChangeScreen,
      showClimateChangeScreenFromActions: showClimateChangeScreenFromActions,
      showAboutScreen: showAboutScreen,
      questionnaireStepsNum: questionnaireStepsNum,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $NavState = _$NavStateTearOff();

/// @nodoc
mixin _$NavState {
  bool get splashScreenSeen;
  int get onboardingStepsNum;
  bool get showAdvicesScreen;
  bool get showClimateChangeScreen;
  bool get showClimateChangeScreenFromActions;
  bool get showAboutScreen;
  int get questionnaireStepsNum;

  $NavStateCopyWith<NavState> get copyWith;
}

/// @nodoc
abstract class $NavStateCopyWith<$Res> {
  factory $NavStateCopyWith(NavState value, $Res Function(NavState) then) =
      _$NavStateCopyWithImpl<$Res>;
  $Res call(
      {bool splashScreenSeen,
      int onboardingStepsNum,
      bool showAdvicesScreen,
      bool showClimateChangeScreen,
      bool showClimateChangeScreenFromActions,
      bool showAboutScreen,
      int questionnaireStepsNum});
}

/// @nodoc
class _$NavStateCopyWithImpl<$Res> implements $NavStateCopyWith<$Res> {
  _$NavStateCopyWithImpl(this._value, this._then);

  final NavState _value;
  // ignore: unused_field
  final $Res Function(NavState) _then;

  @override
  $Res call({
    Object splashScreenSeen = freezed,
    Object onboardingStepsNum = freezed,
    Object showAdvicesScreen = freezed,
    Object showClimateChangeScreen = freezed,
    Object showClimateChangeScreenFromActions = freezed,
    Object showAboutScreen = freezed,
    Object questionnaireStepsNum = freezed,
  }) {
    return _then(_value.copyWith(
      splashScreenSeen: splashScreenSeen == freezed
          ? _value.splashScreenSeen
          : splashScreenSeen as bool,
      onboardingStepsNum: onboardingStepsNum == freezed
          ? _value.onboardingStepsNum
          : onboardingStepsNum as int,
      showAdvicesScreen: showAdvicesScreen == freezed
          ? _value.showAdvicesScreen
          : showAdvicesScreen as bool,
      showClimateChangeScreen: showClimateChangeScreen == freezed
          ? _value.showClimateChangeScreen
          : showClimateChangeScreen as bool,
      showClimateChangeScreenFromActions:
          showClimateChangeScreenFromActions == freezed
              ? _value.showClimateChangeScreenFromActions
              : showClimateChangeScreenFromActions as bool,
      showAboutScreen: showAboutScreen == freezed
          ? _value.showAboutScreen
          : showAboutScreen as bool,
      questionnaireStepsNum: questionnaireStepsNum == freezed
          ? _value.questionnaireStepsNum
          : questionnaireStepsNum as int,
    ));
  }
}

/// @nodoc
abstract class _$NavStateCopyWith<$Res> implements $NavStateCopyWith<$Res> {
  factory _$NavStateCopyWith(_NavState value, $Res Function(_NavState) then) =
      __$NavStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool splashScreenSeen,
      int onboardingStepsNum,
      bool showAdvicesScreen,
      bool showClimateChangeScreen,
      bool showClimateChangeScreenFromActions,
      bool showAboutScreen,
      int questionnaireStepsNum});
}

/// @nodoc
class __$NavStateCopyWithImpl<$Res> extends _$NavStateCopyWithImpl<$Res>
    implements _$NavStateCopyWith<$Res> {
  __$NavStateCopyWithImpl(_NavState _value, $Res Function(_NavState) _then)
      : super(_value, (v) => _then(v as _NavState));

  @override
  _NavState get _value => super._value as _NavState;

  @override
  $Res call({
    Object splashScreenSeen = freezed,
    Object onboardingStepsNum = freezed,
    Object showAdvicesScreen = freezed,
    Object showClimateChangeScreen = freezed,
    Object showClimateChangeScreenFromActions = freezed,
    Object showAboutScreen = freezed,
    Object questionnaireStepsNum = freezed,
  }) {
    return _then(_NavState(
      splashScreenSeen: splashScreenSeen == freezed
          ? _value.splashScreenSeen
          : splashScreenSeen as bool,
      onboardingStepsNum: onboardingStepsNum == freezed
          ? _value.onboardingStepsNum
          : onboardingStepsNum as int,
      showAdvicesScreen: showAdvicesScreen == freezed
          ? _value.showAdvicesScreen
          : showAdvicesScreen as bool,
      showClimateChangeScreen: showClimateChangeScreen == freezed
          ? _value.showClimateChangeScreen
          : showClimateChangeScreen as bool,
      showClimateChangeScreenFromActions:
          showClimateChangeScreenFromActions == freezed
              ? _value.showClimateChangeScreenFromActions
              : showClimateChangeScreenFromActions as bool,
      showAboutScreen: showAboutScreen == freezed
          ? _value.showAboutScreen
          : showAboutScreen as bool,
      questionnaireStepsNum: questionnaireStepsNum == freezed
          ? _value.questionnaireStepsNum
          : questionnaireStepsNum as int,
    ));
  }
}

/// @nodoc
class _$_NavState implements _NavState {
  _$_NavState(
      {this.splashScreenSeen = false,
      this.onboardingStepsNum = 0,
      this.showAdvicesScreen = false,
      this.showClimateChangeScreen = false,
      this.showClimateChangeScreenFromActions = false,
      this.showAboutScreen = false,
      this.questionnaireStepsNum = 0})
      : assert(splashScreenSeen != null),
        assert(onboardingStepsNum != null),
        assert(showAdvicesScreen != null),
        assert(showClimateChangeScreen != null),
        assert(showClimateChangeScreenFromActions != null),
        assert(showAboutScreen != null),
        assert(questionnaireStepsNum != null);

  @JsonKey(defaultValue: false)
  @override
  final bool splashScreenSeen;
  @JsonKey(defaultValue: 0)
  @override
  final int onboardingStepsNum;
  @JsonKey(defaultValue: false)
  @override
  final bool showAdvicesScreen;
  @JsonKey(defaultValue: false)
  @override
  final bool showClimateChangeScreen;
  @JsonKey(defaultValue: false)
  @override
  final bool showClimateChangeScreenFromActions;
  @JsonKey(defaultValue: false)
  @override
  final bool showAboutScreen;
  @JsonKey(defaultValue: 0)
  @override
  final int questionnaireStepsNum;

  @override
  String toString() {
    return 'NavState(splashScreenSeen: $splashScreenSeen, onboardingStepsNum: $onboardingStepsNum, showAdvicesScreen: $showAdvicesScreen, showClimateChangeScreen: $showClimateChangeScreen, showClimateChangeScreenFromActions: $showClimateChangeScreenFromActions, showAboutScreen: $showAboutScreen, questionnaireStepsNum: $questionnaireStepsNum)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NavState &&
            (identical(other.splashScreenSeen, splashScreenSeen) ||
                const DeepCollectionEquality()
                    .equals(other.splashScreenSeen, splashScreenSeen)) &&
            (identical(other.onboardingStepsNum, onboardingStepsNum) ||
                const DeepCollectionEquality()
                    .equals(other.onboardingStepsNum, onboardingStepsNum)) &&
            (identical(other.showAdvicesScreen, showAdvicesScreen) ||
                const DeepCollectionEquality()
                    .equals(other.showAdvicesScreen, showAdvicesScreen)) &&
            (identical(
                    other.showClimateChangeScreen, showClimateChangeScreen) ||
                const DeepCollectionEquality().equals(
                    other.showClimateChangeScreen, showClimateChangeScreen)) &&
            (identical(other.showClimateChangeScreenFromActions,
                    showClimateChangeScreenFromActions) ||
                const DeepCollectionEquality().equals(
                    other.showClimateChangeScreenFromActions,
                    showClimateChangeScreenFromActions)) &&
            (identical(other.showAboutScreen, showAboutScreen) ||
                const DeepCollectionEquality()
                    .equals(other.showAboutScreen, showAboutScreen)) &&
            (identical(other.questionnaireStepsNum, questionnaireStepsNum) ||
                const DeepCollectionEquality().equals(
                    other.questionnaireStepsNum, questionnaireStepsNum)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(splashScreenSeen) ^
      const DeepCollectionEquality().hash(onboardingStepsNum) ^
      const DeepCollectionEquality().hash(showAdvicesScreen) ^
      const DeepCollectionEquality().hash(showClimateChangeScreen) ^
      const DeepCollectionEquality().hash(showClimateChangeScreenFromActions) ^
      const DeepCollectionEquality().hash(showAboutScreen) ^
      const DeepCollectionEquality().hash(questionnaireStepsNum);

  @override
  _$NavStateCopyWith<_NavState> get copyWith =>
      __$NavStateCopyWithImpl<_NavState>(this, _$identity);
}

abstract class _NavState implements NavState {
  factory _NavState(
      {bool splashScreenSeen,
      int onboardingStepsNum,
      bool showAdvicesScreen,
      bool showClimateChangeScreen,
      bool showClimateChangeScreenFromActions,
      bool showAboutScreen,
      int questionnaireStepsNum}) = _$_NavState;

  @override
  bool get splashScreenSeen;
  @override
  int get onboardingStepsNum;
  @override
  bool get showAdvicesScreen;
  @override
  bool get showClimateChangeScreen;
  @override
  bool get showClimateChangeScreenFromActions;
  @override
  bool get showAboutScreen;
  @override
  int get questionnaireStepsNum;
  @override
  _$NavStateCopyWith<_NavState> get copyWith;
}
