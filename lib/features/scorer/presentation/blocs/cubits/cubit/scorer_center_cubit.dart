import 'package:bloc/bloc.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
part 'scorer_center_state.dart';

class ScoreCenterCubit extends Cubit<ScoreCenterState> {
  ScoreCenterCubit() : super(ScoreCenterState());

  setExtraType(ExtraType? extraType) {
    emit(state.copyWith(extraType: extraType));
  }

  newWicket(bool wicket) {
    emit(state.copyWith(extraType: state.extraType, wicket: wicket));
  }

  optionType(OptionType? optionType) {
    emit(
      state.copyWith(
        extraType: state.extraType,
        wicket: false,
        optionType: optionType,
      ),
    );
  }
}
