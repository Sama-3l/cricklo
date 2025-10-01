part of 'otp_page_cubit.dart';

@immutable
sealed class OtpPageState {
  final String otp;
  final bool loading;

  const OtpPageState({required this.otp, this.loading = false});
}

final class OtpPageUpdate extends OtpPageState {
  const OtpPageUpdate({required super.otp, super.loading});
}

final class OtpPageLoading extends OtpPageState {
  const OtpPageLoading({required super.otp, super.loading});
}
