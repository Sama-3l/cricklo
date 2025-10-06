import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'create_team_state.dart';

class CreateTeamCubit extends Cubit<CreateTeamState> {
  CreateTeamCubit() : super(CreateTeamUpdate());
}
