import 'package:cricklo/features/teams/domain/entities/invite_entity.dart';

class InviteModel {
  final String id;
  final String receiverProfileId;
  final String receiverPlayerId;
  final String status;

  InviteModel({
    required this.id,
    required this.receiverProfileId,
    required this.receiverPlayerId,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'receiverProfileId': receiverProfileId,
      'receiverPlayerId': receiverPlayerId,
      'status': status,
    };
  }

  factory InviteModel.fromJson(Map<String, dynamic> map) {
    return InviteModel(
      id: map['id'] as String,
      receiverProfileId: map['receiverProfileId'] as String,
      receiverPlayerId: map['receiverPlayerId'] as String,
      status: map['status'] as String,
    );
  }

  InviteEntity toEntity() {
    return InviteEntity(
      id: id,
      receiverProfileId: receiverProfileId,
      receiverPlayerId: receiverPlayerId,
      status: status,
    );
  }
}
