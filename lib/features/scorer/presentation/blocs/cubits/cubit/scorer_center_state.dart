part of 'scorer_center_cubit.dart';

class ScoreCenterState {
  final ExtraType? extraType;
  final bool wicket;
  final OptionType? optionType;

  ScoreCenterState({this.extraType, this.wicket = false, this.optionType});

  ScoreCenterState copyWith({
    ExtraType? extraType,
    bool? wicket,
    OptionType? optionType,
  }) {
    return ScoreCenterState(
      extraType: extraType,
      wicket: wicket ?? this.wicket,
      optionType: optionType,
    );
  }
}
