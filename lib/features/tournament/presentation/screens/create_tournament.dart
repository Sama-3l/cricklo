import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/common/textfield.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:cricklo/features/tournament/presentation/blocs/cubits/CreateTournamentCubit/create_tournament_cubit.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateTournament extends StatefulWidget {
  const CreateTournament({super.key, required this.onCreate});

  final Function(TournamentEntity tournament) onCreate;

  @override
  State<CreateTournament> createState() => _CreateTournamentState();
}

class _CreateTournamentState extends State<CreateTournament> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController teamsLimitController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode teamsLimitFocus = FocusNode();

  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _invitationDeadline;
  String? _selectedFormat;
  String? _ballType;

  @override
  void initState() {
    super.initState();

    nameController.addListener(_refresh);
    nameController.addListener(_refresh);

    nameFocus.addListener(_refresh);
    teamsLimitFocus.addListener(_refresh);
  }

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      builder: (context, state) {
        final cubit = context.read<CreateTournamentCubit>();

        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorsConstants.defaultWhite,
          appBar: AppBar(
            backgroundColor: ColorsConstants.accentOrange,
            leading: IconButton(
              onPressed: () => GoRouter.of(context).pop(),
              icon: Icon(
                Icons.chevron_left,
                color: ColorsConstants.defaultWhite,
              ),
              iconSize: 32,
            ),
            title: Text(
              "Create Tournament",
              style: TextStyles.poppinsMedium.copyWith(
                fontSize: 24,
                letterSpacing: -1.2,
                color: ColorsConstants.defaultWhite,
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ).copyWith(bottom: 16),
            child: SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                disabled:
                    nameController.text.isEmpty ||
                    _startDate == null ||
                    _endDate == null ||
                    _invitationDeadline == null ||
                    _selectedFormat == null ||
                    _ballType == null ||
                    state.banner == null,

                child: state.loading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: ColorsConstants.defaultWhite,
                        ),
                      )
                    : Text(
                        "Continue",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 16,
                          letterSpacing: -0.6,
                          color: ColorsConstants.defaultWhite,
                        ),
                      ),
                onPress: () async {
                  final banner = await Methods.imageToBase64(state.banner!);
                  final tournament = TournamentEntity(
                    tournamentType: TournamentType.knockout,
                    id: "",
                    name: nameController.text,
                    banner: banner,
                    maxTeams: int.parse(teamsLimitController.text),
                    inviteDeadline: _invitationDeadline!,
                    startDate: _startDate!,
                    endDate: _endDate!,
                    ballType: BallType.values.firstWhere(
                      (e) => e.title == _ballType!.split(' ')[0],
                    ),
                    matchType: MatchType.values.firstWhere(
                      (e) => e.matchType == _selectedFormat,
                    ),
                    overs: _selectedFormat!.toLowerCase() == "odi"
                        ? 50
                        : _selectedFormat!.toLowerCase() == "t10"
                        ? 10
                        : _selectedFormat!.toLowerCase() == "t20"
                        ? 20
                        : _selectedFormat!.toLowerCase() == "t30"
                        ? 30
                        : 0,
                    moderators: [],
                    venues: [],
                    teams: [],
                    matches: [],
                    groups: [],
                    playerStats: [],
                  );
                  GoRouter.of(context).push(
                    Routes.addTournamentVenues,
                    extra: [tournament, widget.onCreate],
                  );
                  // final team = TeamEntity(
                  //   inviteStatus: null,
                  //   uuid: "",
                  //   id: "",
                  //   name: nameController.text.trim(),
                  //   teamLogo: teamLogo,
                  //   teamBanner: teamBanner,
                  //   players: [],
                  //   location: LocationEntity(
                  //     area: areaController.text.trim(),
                  //     city: cityController.text.trim(),
                  //     state: stateController.text.trim(),
                  //     lat: 0,
                  //     lng: 0,
                  //   ),
                  // );
                  // cubit.createTeam(team, context);
                },
              ),
            ),
          ),
          body: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                state.banner != null
                    ? Image.file(
                        state.banner!,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      )
                    : InkWell(
                        onTap: () => cubit.pickBanner(),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          color: ColorsConstants.surfaceOrange,
                          child: Center(
                            child: state.bannerLoading
                                ? SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: ColorsConstants.defaultBlack,
                                    ),
                                  )
                                : Text(
                                    "Tournament Thumbnail Required",
                                    style: TextStyles.poppinsSemiBold.copyWith(
                                      fontSize: 16,
                                      letterSpacing: -0.8,
                                      color: ColorsConstants.defaultBlack,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: InputField(
                    scrollPadding: false,
                    title: "Tournament Name * ",
                    // onSubmitted: (_) =>
                    //     Focus.of(context).requestFocus(areaNode),
                    focusNode: nameFocus,
                    controller: nameController,
                    hintText: "Rajasthan Premier League",
                    showBuilder: false,
                    prefixIcon: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        nameFocus.hasFocus
                            ? Icons.people
                            : Icons.people_outline,
                        size: 20,
                        color: nameFocus.hasFocus
                            ? ColorsConstants.defaultBlack
                            : ColorsConstants.defaultBlack.withValues(
                                alpha: 0.3,
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Start Date",
                              style: TextStyles.poppinsSemiBold.copyWith(
                                fontSize: 12,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () async {
                                await Methods.pickDate(context, _startDate, (
                                  pickedDate,
                                ) async {
                                  if (pickedDate != null) {
                                    setState(() {
                                      _startDate = pickedDate;
                                    });
                                  }
                                });
                              },
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ColorsConstants.onSurfaceGrey,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  labelStyle: TextStyles.poppinsMedium.copyWith(
                                    fontSize: 16,
                                    letterSpacing: -0.8,
                                    color: ColorsConstants.defaultBlack,
                                  ),
                                ),
                                child: Text(
                                  _startDate == null
                                      ? "Select Date"
                                      : "${_startDate!.day}/${_startDate!.month}/${_startDate!.year}",
                                  style: TextStyles.poppinsMedium.copyWith(
                                    fontSize: 16,
                                    letterSpacing: -0.8,
                                    color: _startDate == null
                                        ? ColorsConstants.defaultBlack
                                              .withValues(alpha: 0.3)
                                        : ColorsConstants.defaultBlack,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "End Date",
                              style: TextStyles.poppinsSemiBold.copyWith(
                                fontSize: 12,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () async {
                                await Methods.pickDate(context, _endDate, (
                                  pickedDate,
                                ) async {
                                  if (pickedDate != null) {
                                    setState(() {
                                      _endDate = pickedDate;
                                    });
                                  }
                                });
                              },
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ColorsConstants.onSurfaceGrey,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  labelStyle: TextStyles.poppinsMedium.copyWith(
                                    fontSize: 16,
                                    letterSpacing: -0.8,
                                    color: ColorsConstants.defaultBlack,
                                  ),
                                ),
                                child: Text(
                                  _endDate == null
                                      ? "Select Date"
                                      : "${_endDate!.day}/${_endDate!.month}/${_endDate!.year}",
                                  style: TextStyles.poppinsMedium.copyWith(
                                    fontSize: 16,
                                    letterSpacing: -0.8,
                                    color: _endDate == null
                                        ? ColorsConstants.defaultBlack
                                              .withValues(alpha: 0.3)
                                        : ColorsConstants.defaultBlack,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Invitation Deadline",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () async {
                          await Methods.pickDate(context, _invitationDeadline, (
                            pickedDate,
                          ) async {
                            if (pickedDate != null) {
                              setState(() {
                                _invitationDeadline = pickedDate;
                              });
                            }
                          });
                        },
                        child: InputDecorator(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ColorsConstants.onSurfaceGrey,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            labelStyle: TextStyles.poppinsMedium.copyWith(
                              fontSize: 16,
                              letterSpacing: -0.8,
                              color: ColorsConstants.defaultBlack,
                            ),
                          ),
                          child: Text(
                            _invitationDeadline == null
                                ? "Select Date"
                                : "${_invitationDeadline!.day}/${_invitationDeadline!.month}/${_invitationDeadline!.year}",
                            style: TextStyles.poppinsMedium.copyWith(
                              fontSize: 16,
                              letterSpacing: -0.8,
                              color: _invitationDeadline == null
                                  ? ColorsConstants.defaultBlack.withValues(
                                      alpha: 0.3,
                                    )
                                  : ColorsConstants.defaultBlack,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                InputField(
                  scrollPadding: true,
                  title: "No. of Teams",
                  focusNode: teamsLimitFocus,
                  textInputType: TextInputType.number,
                  controller: teamsLimitController,
                  hintText: "16 (has to be even)",
                  showBuilder: false,
                  prefixIcon: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      teamsLimitFocus.hasFocus
                          ? Icons.people
                          : Icons.people_outline,
                      size: 20,
                      color: teamsLimitFocus.hasFocus
                          ? ColorsConstants.defaultBlack
                          : ColorsConstants.defaultBlack.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Format",
                              style: TextStyles.poppinsSemiBold.copyWith(
                                fontSize: 12,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              dropdownColor: ColorsConstants.defaultWhite,
                              initialValue: _selectedFormat,
                              decoration: InputDecoration(
                                labelText: _selectedFormat == null
                                    ? "Match Format"
                                    : "",
                                filled: true,
                                labelStyle: TextStyles.poppinsMedium.copyWith(
                                  fontSize: 16,
                                  letterSpacing: -0.8,
                                  color: ColorsConstants.defaultBlack
                                      .withValues(alpha: 0.3),
                                ),
                                fillColor: ColorsConstants.onSurfaceGrey,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              items: MatchType.values
                                  .map(
                                    (f) => DropdownMenuItem(
                                      value: f.matchType,
                                      child: Text(
                                        f.matchType,
                                        style: TextStyles.poppinsMedium
                                            .copyWith(
                                              fontSize: 16,
                                              letterSpacing: -0.8,
                                            ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  _selectedFormat = val;
                                });
                              },
                              validator: (val) =>
                                  val == null ? "Select a match format" : null,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ball Type",
                              style: TextStyles.poppinsSemiBold.copyWith(
                                fontSize: 12,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              dropdownColor: ColorsConstants.defaultWhite,
                              initialValue: _ballType,
                              decoration: InputDecoration(
                                labelText: _ballType == null ? "Ball Type" : "",
                                filled: true,
                                labelStyle: TextStyles.poppinsMedium.copyWith(
                                  fontSize: 16,
                                  letterSpacing: -0.8,
                                  color: ColorsConstants.defaultBlack
                                      .withValues(alpha: 0.3),
                                ),
                                fillColor: ColorsConstants.onSurfaceGrey,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              items:
                                  ["Tennis Ball", "Leather Ball", "Rubber Ball"]
                                      .map(
                                        (f) => DropdownMenuItem(
                                          value: f,
                                          child: Text(
                                            f,
                                            style: TextStyles.poppinsMedium
                                                .copyWith(
                                                  fontSize: 16,
                                                  letterSpacing: -0.8,
                                                ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (val) {
                                setState(() {
                                  _ballType = val;
                                });
                              },
                              validator: (val) =>
                                  val == null ? "Select a match format" : null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
