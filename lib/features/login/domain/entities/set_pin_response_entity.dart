class SetPinResponseEntity {
  final bool success;
  final String? message;
  final String? errorCode;
  final String? errorMessage;
  final int? status;
  final bool? onboarded;

  const SetPinResponseEntity({
    required this.success,
    this.message,
    this.errorCode,
    this.errorMessage,
    this.status,
    this.onboarded,
  });

  SetPinResponseEntity copyWith({
    bool? success,
    String? message,
    String? errorCode,
    String? errorMessage,
    int? status,
    bool? onboarded,
  }) {
    return SetPinResponseEntity(
      success: success ?? this.success,
      message: message ?? this.message,
      errorCode: errorCode ?? this.errorCode,
      errorMessage: errorMessage ?? this.errorMessage,
      onboarded: onboarded ?? this.onboarded,
    );
  }
}
