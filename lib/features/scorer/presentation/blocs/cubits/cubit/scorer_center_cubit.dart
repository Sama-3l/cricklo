import 'package:bloc/bloc.dart';

part 'scorer_center_state.dart';

class ScoreCenterCubit extends Cubit<ScoreCenterState> {
  ScoreCenterCubit() : super(ScoreCenterState.initial());

  void selectBatsman(String batsman, {required bool onStrike}) {
    if (onStrike) {
      emit(state.copyWith(onStrikeBatsman: batsman));
    } else {
      emit(state.copyWith(offStrikeBatsman: batsman));
    }
  }

  void selectBowler(String bowler) {
    emit(state.copyWith(currentBowler: bowler));
  }

  void addRun(int runs, {bool isExtra = false}) {
    emit(
      state.copyWith(
        totalRuns: state.totalRuns + runs,
        balls: isExtra ? state.balls : state.balls + 1,
      ),
    );
    _rotateStrikeIfNeeded(runs);
  }

  void _rotateStrikeIfNeeded(int runs) {
    if (runs.isOdd) {
      emit(
        state.copyWith(
          onStrikeBatsman: state.offStrikeBatsman,
          offStrikeBatsman: state.onStrikeBatsman,
        ),
      );
    }
  }

  void nextOver() {
    emit(
      state.copyWith(
        balls: 0,
        overs: state.overs + 1,
        onStrikeBatsman: state.offStrikeBatsman,
        offStrikeBatsman: state.onStrikeBatsman,
      ),
    );
  }

  void wicket() {
    emit(state.copyWith(wickets: state.wickets + 1));
  }
}
