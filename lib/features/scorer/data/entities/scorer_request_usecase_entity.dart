import 'package:cricklo/features/scorer/domain/entities/match_center_entity.dart';
import 'package:cricklo/features/scorer/domain/models/remote/match_center_model.dart';

class ScorerRequestUsecaseEntity {
  final bool undo;
  final MatchCenterEntity matchCenterEntity;

  ScorerRequestUsecaseEntity({
    required this.undo,
    required this.matchCenterEntity,
  });

  Map<String, dynamic> toJson() {
    return {
      'undo': undo,
      'matchCenterEntity': MatchCenterModel.fromEntity(
        matchCenterEntity,
      ).toJson(),
    };
  }
}
