class ApiEndpointConstants {
  static const registerNumber = 'auth/register';
  static const verifyOTP = 'auth/verify';
  static const setPassword = 'auth/set-password';
  static const logout = 'auth/logout';
  static const login = 'auth/login';

  static const onboarding = '/profile/onboarding';
  static const getCurrentUser = '/profile/me';
  static const getMyTeams = "/profile/my-teams";
  static const searchteams = "/team/find";
  static const getNotifications = '/profile/notifications';

  static const createTeam = '/team/create';
  static const searchPlayers = "/team/players/search";
  static const getTeamDetails = "/team/{teamId}";
  static const invitePlayers = "/team/{teamId}/invite";
  static const teamInviteResponse = "team/{teamId}/invites/{inviteId}/respond";

  static const createMatch = '/match/create';
  static const getUserMatches = '/match/user';
}
