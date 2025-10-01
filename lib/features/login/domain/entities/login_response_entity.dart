class LoginResponseEntity {
  final bool success;
  final String? message;
  final String? errorCode;
  final String? errorMessage;
  final int? status;

  const LoginResponseEntity({
    required this.success,
    this.message,
    this.errorCode,
    this.errorMessage,
    this.status,
  });

  LoginResponseEntity copyWith({
    bool? success,
    String? message,
    String? errorCode,
    String? errorMessage,
    int? status,
  }) {
    return LoginResponseEntity(
      success: success ?? this.success,
      message: message ?? this.message,
      errorCode: errorCode ?? this.errorCode,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
