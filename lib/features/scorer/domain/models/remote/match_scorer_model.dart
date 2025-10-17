// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/scorer/domain/entities/scorer_entity.dart';

class MatchScorerModel {
  final String playerId;
  final String name;
  final String? profilePic;

  MatchScorerModel({
    required this.playerId,
    required this.name,
    required this.profilePic,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'playerId': playerId,
      'name': name,
      'profilePic': profilePic,
    };
  }

  MatchScorerEntity toEntity() {
    return MatchScorerEntity(
      playerId: playerId,
      name: name,
      profilePic: profilePic,
    );
  }

  factory MatchScorerModel.fromEntity(MatchScorerEntity entity) {
    return MatchScorerModel(
      playerId: entity.playerId,
      name: entity.name,
      profilePic: entity.profilePic,
    );
  }

  factory MatchScorerModel.fromMap(Map<String, dynamic> map) {
    return MatchScorerModel(
      playerId: map['playerId'] as String,
      name: map['name'] as String,
      profilePic: map['profilePic'] as String?,
    );
  }
}
