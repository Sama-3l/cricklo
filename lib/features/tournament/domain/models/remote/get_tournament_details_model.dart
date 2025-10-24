import 'package:cricklo/features/tournament/domain/entities/get_tournament_details_entity.dart';
import 'package:cricklo/features/tournament/domain/models/remote/tournament_model.dart';

class GetTournamentDetailsModel {
  final bool success;
  final TournamentModel? tournamentModel;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  GetTournamentDetailsModel({
    required this.success,
    this.tournamentModel,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'team': tournamentModel!.toJson(),
      'message': message,
      'status': status,
      'errorCode': errorCode,
      'errorMessage': errorMessage,
    };
  }

  factory GetTournamentDetailsModel.fromJson(Map<String, dynamic> map) {
    return GetTournamentDetailsModel(
      success: map['success'] as bool,
      tournamentModel: TournamentModel.fromJson(
        map['payload'] as Map<String, dynamic>,
      ),
      message: map['message'] != null ? map['message'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      errorCode: map['errorCode'] != null ? map['errorCode'] as String : null,
      errorMessage: map['errorMessage'] != null
          ? map['errorMessage'] as String
          : null,
    );
  }

  GetTournamentDetailsEntity toEntity() {
    return GetTournamentDetailsEntity(
      success: success,
      tournamentEntity: tournamentModel!.toEntity(),
      message: message,
      status: status,
      errorMessage: errorMessage,
      errorCode: errorCode,
    );
  }
}
