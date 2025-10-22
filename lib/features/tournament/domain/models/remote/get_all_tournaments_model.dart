import 'package:cricklo/features/tournament/domain/entities/get_all_tournaments_entity.dart';
import 'package:cricklo/features/tournament/domain/models/remote/tournament_model.dart';

class GetAllTournamentsModel {
  final bool success;
  final List<TournamentModel>? tournaments;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  GetAllTournamentsModel({
    required this.success,
    this.tournaments,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'tournaments': tournaments?.map((x) => x.toJson()).toList(),
      'message': message,
      'status': status,
      'errorCode': errorCode,
      'errorMessage': errorMessage,
    };
  }

  GetAllTournamentsEntity toEntity() {
    return GetAllTournamentsEntity(
      success: success,
      tournaments: tournaments?.map((x) => x.toEntity()).toList(),
      message: message,
      status: status,
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }

  factory GetAllTournamentsModel.fromJson(Map<String, dynamic> map) {
    return GetAllTournamentsModel(
      success: map['success'] as bool,
      tournaments: map['payload'] != null
          ? List<TournamentModel>.from(
              (map['payload'] as List<dynamic>).map<TournamentModel?>(
                (x) => TournamentModel.fromMap(x),
              ),
            )
          : null,
      message: map['message'] != null ? map['message'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      errorCode: map['errorCode'] != null ? map['errorCode'] as String : null,
      errorMessage: map['errorMessage'] != null
          ? map['errorMessage'] as String
          : null,
    );
  }
}
