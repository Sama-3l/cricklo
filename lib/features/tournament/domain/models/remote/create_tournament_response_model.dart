import 'package:cricklo/features/tournament/domain/entities/create_tournament_response_entity.dart';

class CreateTournamentResponseModel {
  final bool success;
  final String? tournamentId;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  CreateTournamentResponseModel({
    required this.success,
    this.tournamentId,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'team': tournamentId,
      'message': message,
      'status': status,
      'errorCode': errorCode,
      'errorMessage': errorMessage,
    };
  }

  factory CreateTournamentResponseModel.fromJson(Map<String, dynamic> map) {
    return CreateTournamentResponseModel(
      success: map['success'] as bool,
      tournamentId: map['payload'] as String,
      message: map['message'] != null ? map['message'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      errorCode: map['errorCode'] != null ? map['errorCode'] as String : null,
      errorMessage: map['errorMessage'] != null
          ? map['errorMessage'] as String
          : null,
    );
  }

  CreateTournamentResponseEntity toEntity() {
    return CreateTournamentResponseEntity(
      success: success,
      tournamentId: tournamentId,
      message: message,
      status: status,
      errorMessage: errorMessage,
      errorCode: errorCode,
    );
  }
}
