// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/scorer/domain/entities/overs_entity.dart';
import 'package:cricklo/features/scorer/domain/models/remote/ball_model.dart';
import 'package:cricklo/features/scorer/domain/models/remote/match_player_model.dart';

class OversModel {
  final int overNumber;
  int runs;
  int wickets;
  int player1runs;
  int player1balls;
  String player1Id;
  String player1Name;
  int player2runs;
  int player2balls;
  String player2Id;
  String player2Name;
  String bowlerId;
  String bowlerName;
  String bowlerOvers;
  int bowlerRuns;
  int bowlerMaidens;
  int bowlerWickets;
  final MatchPlayerModel bowler;
  final List<BallModel> balls;

  OversModel({
    required this.overNumber,
    required this.runs,
    required this.wickets,
    required this.player1runs,
    required this.player1balls,
    required this.player1Id,
    required this.player1Name,
    required this.player2runs,
    required this.player2balls,
    required this.player2Id,
    required this.player2Name,
    required this.bowlerId,
    required this.bowlerName,
    required this.bowlerOvers,
    required this.bowlerRuns,
    required this.bowlerMaidens,
    required this.bowlerWickets,
    required this.bowler,
    required this.balls,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'overNumber': overNumber,
      'runs': runs,
      'wickets': wickets,
      'player1runs': player1runs,
      'player1balls': player1balls,
      'player1Id': player1Id,
      'player1Name': player1Name,
      'player2runs': player2runs,
      'player2balls': player2balls,
      'player2Id': player2Id,
      'player2Name': player2Name,
      'bowlerId': bowlerId,
      'bowlerName': bowlerName,
      'bowlerOvers': bowlerOvers,
      'bowlerRuns': bowlerRuns,
      'bowlerMaidens': bowlerMaidens,
      'bowlerWickets': bowlerWickets,
      'bowler': bowler.playerId,
      'balls': balls.map((x) => x.toJson()).toList(),
    };
  }

  OversEntity toEntity() {
    return OversEntity(
      overNumber: overNumber,
      runs: runs,
      wickets: wickets,
      player1runs: player1runs,
      player1balls: player1balls,
      player1Id: player1Id,
      player1Name: player1Name,
      player2runs: player2runs,
      player2balls: player2balls,
      player2Id: player2Id,
      player2Name: player2Name,
      bowlerId: bowlerId,
      bowlerName: bowlerName,
      bowlerOvers: bowlerOvers,
      bowlerRuns: bowlerRuns,
      bowlerMaidens: bowlerMaidens,
      bowlerWickets: bowlerWickets,
      bowler: bowler.toEntity(),
      balls: balls.map((e) => e.toEntity()).toList(),
    );
  }

  factory OversModel.fromEntity(OversEntity entity) {
    return OversModel(
      overNumber: entity.overNumber,
      runs: entity.runs,
      wickets: entity.wickets,
      player1runs: entity.player1runs,
      player1balls: entity.player1balls,
      player1Id: entity.player1Id,
      player1Name: entity.player1Name,
      player2runs: entity.player2runs,
      player2balls: entity.player2balls,
      player2Id: entity.player2Id,
      player2Name: entity.player2Name,
      bowlerId: entity.bowlerId,
      bowlerName: entity.bowlerName,
      bowlerOvers: entity.bowlerOvers,
      bowlerRuns: entity.bowlerRuns,
      bowlerMaidens: entity.bowlerMaidens,
      bowlerWickets: entity.bowlerWickets,
      bowler: MatchPlayerModel.fromEntity(entity.bowler),
      balls: entity.balls.map((e) => BallModel.fromEntity(e)).toList(),
    );
  }

  factory OversModel.fromJson(
    Map<String, dynamic> map,
    List<MatchPlayerModel> battingTeamPlayers,
    List<MatchPlayerModel> bowlingTeamPlayers,
  ) {
    return OversModel(
      overNumber: map['overNumber'] as int,
      runs: map['runs'] as int,
      wickets: map['wickets'] as int,
      player1runs: map['player1runs'] as int,
      player1balls: map['player1balls'] as int,
      player1Id: map['player1Id'] as String,
      player1Name: map['player1Name'] as String,
      player2runs: map['player2runs'] as int,
      player2balls: map['player2balls'] as int,
      player2Id: map['player2Id'] as String,
      player2Name: map['player2Name'] as String,
      bowlerId: map['bowlerId'] as String,
      bowlerName: map['bowlerName'] as String,
      bowlerOvers: map['bowlerOvers'] as String,
      bowlerRuns: map['bowlerRuns'] as int,
      bowlerMaidens: map['bowlerMaidens'] as int,
      bowlerWickets: map['bowlerWickets'] as int,
      bowler: MatchPlayerModel.fromMap(map['bowler']),
      balls: List<BallModel>.from(
        (map['balls'] as List<dynamic>).map<BallModel>(
          (x) => BallModel.fromJson(x, battingTeamPlayers, bowlingTeamPlayers),
        ),
      ),
    );
  }
}
