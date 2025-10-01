part of 'login_page_cubit.dart';

@immutable
sealed class LoginPageState {
  final TextEditingController? controller;
  final bool loading;

  const LoginPageState({this.controller, this.loading = false});
}

final class LoginPageUpdateState extends LoginPageState {
  const LoginPageUpdateState({super.controller, super.loading});
}

final class LoginPageLoading extends LoginPageState {
  const LoginPageLoading({super.controller, super.loading});
}
