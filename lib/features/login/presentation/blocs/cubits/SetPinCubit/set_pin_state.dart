part of 'set_pin_cubit.dart';

@immutable
sealed class SetPinState {
  final String pin;
  final bool loading;

  const SetPinState({required this.pin, this.loading = false});
}

final class SetPinUpdate extends SetPinState {
  const SetPinUpdate({required super.pin, super.loading});
}

final class SetPinLoading extends SetPinState {
  const SetPinLoading({required super.pin, super.loading});
}
