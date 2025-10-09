import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'scorer_match_center_state.dart';

class ScorerMatchCenterCubit extends Cubit<ScorerMatchCenterState> {
  ScorerMatchCenterCubit()
    : super(ScorerMatchCenterUpdate(currentIndex: 0, loadedTabs: {0}));

  void changeTab(int index) {
    final newLoadedTabs = {...state.loadedTabs, index};
    emit(state.copyWith(currentIndex: index, loadedTabs: newLoadedTabs));
  }
}
