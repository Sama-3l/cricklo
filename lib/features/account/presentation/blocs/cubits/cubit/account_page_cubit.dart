import 'package:bloc/bloc.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';

part 'account_page_state.dart';

class AccountCubit extends Cubit<AccountPageState> {
  AccountCubit() : super(const AccountPageState());

  init(UserEntity? userEntity) => emit(state.copyWith(userEntity: userEntity));

  void changeMainTab(int index) {
    emit(state.copyWith(selectedMainTab: index));
  }

  void changeStatisticsTab(int index) {
    emit(state.copyWith(selectedStatisticsTab: index));
  }
}
