class OnboardingUsecaseEntity {
  final String name;
  final String email;
  final String playerType;
  final String? profilePhoto;
  final String? batsmanType;
  final String? bowlerType;
  final String area;
  final String city;
  final String state;
  final String phoneNumber;
  final String countryCode;

  OnboardingUsecaseEntity({
    required this.name,
    required this.email,
    required this.playerType,
    this.batsmanType,
    this.bowlerType,
    this.profilePhoto,
    required this.area,
    required this.city,
    required this.state,
    required this.phoneNumber,
    this.countryCode = "+91",
  });

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Email": email,
    "Player_Type": playerType,
    "Batsman_Type": batsmanType,
    "Bowler_Type": bowlerType,
    "Profile_Photo": profilePhoto,
    "Area": area,
    "City": city,
    "State": state,
    "PhoneNumber": phoneNumber,
    "CountryCode": countryCode,
  };
}
