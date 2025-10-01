import 'package:cricklo/features/notifications/domain/entities/logout_entity.dart';

class LogoutModelRemote {
  final bool success;
  final bool? onboarded;
  final bool? errorMessage;

  LogoutModelRemote({required this.success, this.onboarded, this.errorMessage});

  LogoutEntity toEntity() {
    return LogoutEntity(
      success: success,
      errorMessage: errorMessage,
      onboarded: onboarded,
    );
  }

  factory LogoutModelRemote.fromEntity(LogoutEntity map) {
    return LogoutModelRemote(
      success: map.success,
      errorMessage: map.errorMessage,
      onboarded: map.onboarded,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'errorMessage': errorMessage,
      'onboarded': onboarded,
    };
  }

  factory LogoutModelRemote.fromJson(Map<String, dynamic> map) {
    return LogoutModelRemote(
      success: map['success'] as bool,
      errorMessage: map['errorMessage'] != null
          ? map['errorMessage'] as bool
          : null,
      onboarded: map["onboarded"],
    );
  }
}
