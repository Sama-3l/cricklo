class LoginUsecaseEntity {
  final String phone;
  final String password;
  final String countryCode;

  LoginUsecaseEntity({
    required this.phone,
    required this.password,
    this.countryCode = "+91",
  });

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "password": password,
    "countryCode": countryCode,
  };
}
