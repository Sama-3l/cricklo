import 'package:cricklo/features/account/domain/models/remote/get_profile_response_model.dart';
import 'package:cricklo/features/account/domain/models/remote/get_teams_response_model.dart';
import 'package:cricklo/features/login/domain/models/remote/login_response_model.dart';
import 'package:cricklo/features/login/domain/models/remote/set_pin_response_model.dart';
import 'package:cricklo/features/login/domain/models/remote/user_model.dart';
import 'package:cricklo/features/matches/domain/models/remote/create_match_response_model.dart';
import 'package:cricklo/features/matches/domain/models/remote/get_user_matches_response_model.dart';
import 'package:cricklo/features/notifications/domain/models/remote/get_notifications_response_model.dart';
import 'package:cricklo/features/notifications/domain/models/remote/logout_model_remote.dart';
import 'package:cricklo/features/notifications/domain/models/remote/invite_response_response_model.dart';
import 'package:cricklo/features/scorer/domain/models/remote/get_match_state_model.dart';
import 'package:cricklo/features/scorer/domain/models/remote/scorer_response_model.dart';
import 'package:cricklo/features/teams/domain/models/remote/create_team_response_model.dart';
import 'package:cricklo/features/teams/domain/models/remote/get_team_details_response_model.dart';
import 'package:cricklo/features/teams/domain/models/remote/invite_player_response_model.dart';
import 'package:cricklo/features/teams/domain/models/remote/search_players_response_model.dart';
import 'package:cricklo/features/teams/domain/models/remote/search_team_response_model.dart';
import 'package:cricklo/services/api_endpoint_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
// import 'package:retrofit/error_logger.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://cricklo.onrender.com/api/v1/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiEndpointConstants.registerNumber)
  Future<LoginResponseModel> register(@Body() Map<String, dynamic> body);

  @POST(ApiEndpointConstants.verifyOTP)
  Future<LoginResponseModel> verifyOTP(@Body() Map<String, dynamic> body);

  @POST(ApiEndpointConstants.setPassword)
  Future<SetPinResponseModel> setPassword(@Body() Map<String, dynamic> body);

  @POST(ApiEndpointConstants.onboarding)
  Future<UserModel> onboarding(@Body() Map<String, dynamic> body);

  @GET(ApiEndpointConstants.getCurrentUser)
  Future<UserModel> getCurrentUser();

  @GET(ApiEndpointConstants.getProfile)
  Future<GetProfileResponseModel> getProfile(@Path("userId") String userId);

  @POST(ApiEndpointConstants.logout)
  Future<LogoutModelRemote> logout();

  @POST(ApiEndpointConstants.login)
  Future<LogoutModelRemote> login(@Body() Map<String, dynamic> body);

  @POST(ApiEndpointConstants.createTeam)
  Future<CreateTeamResponseModel> createTeam(@Body() Map<String, dynamic> body);

  @GET(ApiEndpointConstants.searchPlayers)
  Future<SearchPlayersResponseModel> searchPlayers(
    @Query("query") String query,
    @Query("page") int page,
    @Query("limit") int limit,
  );

  @POST(ApiEndpointConstants.invitePlayers)
  Future<InvitePlayerResponseModel> invitePlayers(
    @Path("teamId") String teamId,
    @Body() Map<String, dynamic> body,
  );

  @GET(ApiEndpointConstants.getMyTeams)
  Future<GetTeamsResponseModel> getMyTeams();

  @GET(ApiEndpointConstants.searchteams)
  Future<SearchTeamResponseModel> searchTeams(@Query("query") String query);

  @POST(ApiEndpointConstants.createMatch)
  Future<CreateMatchResponseModel> createMatch(
    @Body() Map<String, dynamic> body,
  );

  @GET(ApiEndpointConstants.getUserMatches)
  Future<GetUserMatchesResponseModel> getUserMatches();

  @GET(ApiEndpointConstants.getNotifications)
  Future<GetNotificationsResponseModel> getNotifications();

  @POST(ApiEndpointConstants.teamInviteResponse)
  Future<InviteResponseResponseModel> teamInviteResponse(
    @Path("teamId") String teamId,
    @Path("inviteId") String inviteId,
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiEndpointConstants.matchInviteResponse)
  Future<InviteResponseResponseModel> matchInviteResponse(
    @Path("matchId") String matchId,
    @Path("inviteId") String inviteId,
    @Body() Map<String, dynamic> body,
  );

  @GET(ApiEndpointConstants.getTeamDetails)
  Future<GetTeamDetailsResponseModel> getTeamDetails(
    @Path("teamId") String teamId,
  );

  @POST(ApiEndpointConstants.scorerMatchStart)
  Future<ScorerResponseModel> startScoring(@Body() Map<String, dynamic> body);

  @POST(ApiEndpointConstants.scorerUpdate)
  Future<ScorerResponseModel> updateScoring(@Body() Map<String, dynamic> body);

  @POST(ApiEndpointConstants.scorerEndOver)
  Future<ScorerResponseModel> endOver(@Body() Map<String, dynamic> body);

  @POST(ApiEndpointConstants.scorerInningsChange)
  Future<ScorerResponseModel> scorerInningsChange(
    @Body() Map<String, dynamic> request,
  );

  @POST(ApiEndpointConstants.scorerMatchComplete)
  Future<ScorerResponseModel> scorerComplete(
    @Body() Map<String, dynamic> request,
  );

  @GET(ApiEndpointConstants.getMatchState)
  Future<GetMatchStateResponseModel> getMatchState(
    @Path("matchId") String matchId,
  );
}
