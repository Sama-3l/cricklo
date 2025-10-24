import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/notifications/domain/entities/tournament_notification_entity.dart';

class TournamentNotificationModel {
  final String id;
  final NotificationType notificationType;
  final String tournamentName;
  final String message;
  final String inviteId;
  final String senderProfileId;
  final String tournamentId;

  TournamentNotificationModel({
    required this.id,
    required this.notificationType,
    required this.tournamentName,
    required this.message,
    required this.inviteId,
    required this.senderProfileId,
    required this.tournamentId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'notificationType': notificationType.name,
      'tournamentName': tournamentName,
      'message': message,
      'inviteId': inviteId,
      'senderProfileId': senderProfileId,
      'tournamentId': tournamentId,
    };
  }

  TournamentNotificationEntity toEntity() {
    return TournamentNotificationEntity(
      id: id,
      notificationType: notificationType,
      tournamentName: tournamentName,
      message: message,
      inviteId: inviteId,
      senderProfileId: senderProfileId,
      tournamentId: tournamentId,
    );
  }

  factory TournamentNotificationModel.fromJson(
    Map<String, dynamic> map,
    NotificationType notificationType,
  ) {
    return TournamentNotificationModel(
      id: map['id'] as String,
      notificationType: notificationType,
      tournamentName: map["enriched"]["tournament"]["name"],
      message: map['message'] as String,
      inviteId: map['inviteId'] as String,
      senderProfileId: map['senderProfileId'] as String,
      tournamentId: map["enriched"]["recordId"] as String,
    );
  }

  factory TournamentNotificationModel.fromEntity(
    TournamentNotificationEntity entity,
  ) {
    return TournamentNotificationModel(
      id: entity.id,
      notificationType: entity.notificationType,
      tournamentName: entity.tournamentName,
      message: entity.message,
      inviteId: entity.inviteId,
      senderProfileId: entity.senderProfileId,
      tournamentId: entity.tournamentId,
    );
  }
}
