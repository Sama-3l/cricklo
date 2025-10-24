class ApiEndpointConstants {
  static const locationAPIBaseUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static const registerNumber = 'auth/register';
  static const verifyOTP = 'auth/verify';
  static const setPassword = 'auth/set-password';
  static const logout = 'auth/logout';
  static const login = 'auth/login';

  static const onboarding = '/profile/onboarding';
  static const getCurrentUser = '/profile/me';
  static const getProfile = '/profile/{userId}';
  static const getMyTeams = "/profile/my-teams";
  static const searchteams = "/team/find";
  static const getNotifications = '/profile/notifications';

  static const createTeam = '/team/create';
  static const searchPlayers = "/team/players/search";
  static const getTeamDetails = "/team/{teamId}";
  static const invitePlayers = "/team/{teamId}/invite";
  static const teamInviteResponse = "team/{teamId}/invites/{inviteId}/respond";
  static const tournamentInviteResponse =
      "tournament/{tournamentId}/invites/{inviteId}/respond";

  static const createMatch = '/match/create';
  static const getUserMatches = '/match/user';
  static const matchInviteResponse =
      '/match/{matchId}/invites/{inviteId}/respond';

  static const getMatchState = '/scorer/{matchId}';
  static const scorerMatchStart = '/scorer/start';
  static const scorerUpdate = '/scorer/score-update';
  static const scorerEndOver = '/scorer/over-end';
  static const scorerInningsChange = '/scorer/innings-change';
  static const scorerMatchComplete = '/scorer/complete';

  static const tournamentCreate = '/tournament/create';
  static const tournamentGetAll = '/tournament/all-tournaments';
  static const tournamentInviteModerators =
      '/tournament/{tournamentId}/invite/moderator';
  static const tournamentInviteTeams = '/tournament/{tournamentId}/invite/team';
  static const tournamentApply = '/tournament/{tournamentId}/apply/team';
  static const tournamentDetails = '/tournament/{tournamentId}';
  static const tournamentCreateGroup = 'tournament/{tournamentId}/create-group';
  static const tournamentAddToGroup = 'tournament/{tournamentId}/add-to-group';
  static const tournamentDeleteGroup =
      '/tournament/delete-group/{tournamentId}';
}
