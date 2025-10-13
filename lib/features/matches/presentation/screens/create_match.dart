import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/common/textfield.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/matches/presentation/blocs/cubits/CreateMatchCubit/create_match_cubit.dart';
import 'package:cricklo/features/matches/presentation/widgets/search_teams_bottom_sheet.dart';
import 'package:cricklo/features/teams/domain/entities/player_entity.dart';
import 'package:cricklo/features/teams/domain/entities/search_user_entity.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:cricklo/features/teams/presentation/widgets/search_players_bottom_sheet.dart';
import 'package:cricklo/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateMatch extends StatefulWidget {
  const CreateMatch({super.key, required this.onComplete});

  final Function(MatchEntity match) onComplete;

  @override
  State<CreateMatch> createState() => _CreateMatchState();
}

class _CreateMatchState extends State<CreateMatch> {
  final TextEditingController venueLocation = TextEditingController();
  final TextEditingController venueArea = TextEditingController();

  final FocusNode venueNode = FocusNode();
  final FocusNode areaNode = FocusNode();

  bool get invalidMatchSetup {
    final sameTeam = teamA != null && teamB != null && teamA!.id == teamB!.id;
    return teamA == null ||
        teamB == null ||
        sameTeam ||
        venueLocation.text.isEmpty ||
        venueArea.text.isEmpty ||
        scorer == null ||
        _selectedDate == null ||
        _selectedTime == null ||
        _selectedFormat == null ||
        venueArea.text.split(', ').length < 3;
  }

  DateTime? _selectedDate;
  TeamEntity? teamA;
  TeamEntity? teamB;
  TimeOfDay? _selectedTime;
  String? _selectedFormat;
  SearchUserEntity? scorer;

  void _refresh() => setState(() {});

  @override
  void initState() {
    super.initState();
    venueLocation.addListener(_refresh);
    venueArea.addListener(_refresh);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CreateMatchCubit>(),
      child: BlocBuilder<CreateMatchCubit, CreateMatchState>(
        builder: (context, state) {
          final cubit = context.read<CreateMatchCubit>();
          return Scaffold(
            backgroundColor: ColorsConstants.defaultWhite,
            appBar: AppBar(
              backgroundColor: ColorsConstants.accentOrange,
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      color: ColorsConstants.defaultWhite,
                    ),
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                  );
                },
              ),
              title: Text(
                "Create Match",
                style: TextStyles.poppinsMedium.copyWith(
                  fontSize: 24,
                  letterSpacing: -1.2,
                  color: ColorsConstants.defaultWhite,
                ),
              ),

              centerTitle: true,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ).copyWith(top: 12, bottom: 16),
              color: ColorsConstants.defaultWhite,
              width: double.infinity,
              child: PrimaryButton(
                disabled: invalidMatchSetup,
                child: state.loading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: ColorsConstants.defaultWhite,
                          strokeWidth: 2.4,
                        ),
                      )
                    : Text(
                        "Create Match",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 16,
                          letterSpacing: -0.6,
                          color: ColorsConstants.defaultWhite,
                        ),
                      ),
                onPress: () => state.loading
                    ? {}
                    : cubit.createMatch(
                        context,
                        teamA!,
                        teamB!,
                        PlayerEntity(
                          profilePic: '',
                          id: scorer!.id,
                          playerId: scorer!.playerId,
                          name: scorer!.name,
                          captain: false,
                          teamRole: TeamRole.invited,
                          playerType: scorer!.playerType,
                          batterType: scorer!.batterType,
                          bowlerType: scorer!.bowlerType,
                        ),
                        Methods.getLocationEntity(
                          venueArea.text,
                          venueLocation.text,
                        ),
                        _selectedDate!,
                        _selectedTime!,
                        _selectedFormat!,
                        _selectedFormat!.toLowerCase() == "odi"
                            ? 50
                            : _selectedFormat!.toLowerCase() == "t10"
                            ? 10
                            : _selectedFormat!.toLowerCase() == "t20"
                            ? 20
                            : _selectedFormat!.toLowerCase() == "t30"
                            ? 30
                            : 0,
                        widget.onComplete,
                      ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                if (teamA != null)
                                  Text(
                                    teamA!.name.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyles.poppinsLight.copyWith(
                                      fontSize: 12,
                                      letterSpacing: 1,
                                      color: ColorsConstants.defaultBlack,
                                    ),
                                  ),
                                if (teamA == null)
                                  Text(
                                    "SELECT TEAM",
                                    style: TextStyles.poppinsLight.copyWith(
                                      fontSize: 12,
                                      letterSpacing: 1,
                                      color: ColorsConstants.defaultBlack,
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                InkWell(
                                  onTap: () async {
                                    final teamA = await showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) =>
                                          SearchTeamsBottomSheet(
                                            initiallySelected: [],
                                          ),
                                    );
                                    if (teamA != null) {
                                      setState(() {
                                        this.teamA = teamA.first;
                                      });
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(40),
                                  child: teamA == null
                                      ? CircleAvatar(
                                          radius: 40,
                                          backgroundColor: ColorsConstants
                                              .accentOrange
                                              .withValues(alpha: 0.2),
                                          child: Icon(
                                            Icons.add,
                                            size: 24,
                                            color: ColorsConstants.defaultBlack,
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 40,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                teamA!.teamLogo,
                                              ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                if (teamB != null)
                                  Text(
                                    teamB!.name.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyles.poppinsLight.copyWith(
                                      fontSize: 12,
                                      letterSpacing: 1,
                                      color: ColorsConstants.defaultBlack,
                                    ),
                                  ),
                                if (teamB == null)
                                  Text(
                                    "SELECT TEAM",
                                    style: TextStyles.poppinsLight.copyWith(
                                      fontSize: 12,
                                      letterSpacing: 1,
                                      color: ColorsConstants.defaultBlack,
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                InkWell(
                                  onTap: () async {
                                    final teamB = await showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) =>
                                          SearchTeamsBottomSheet(
                                            initiallySelected: [],
                                          ),
                                    );
                                    if (teamB != null) {
                                      setState(() {
                                        this.teamB = teamB.first;
                                      });
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(40),
                                  child: teamB == null
                                      ? CircleAvatar(
                                          radius: 40,
                                          backgroundColor: ColorsConstants
                                              .accentOrange
                                              .withValues(alpha: 0.2),
                                          child: Icon(
                                            Icons.add,
                                            size: 24,
                                            color: ColorsConstants.defaultBlack,
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 40,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                teamB!.teamLogo,
                                              ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      InputField(
                        scrollPadding: false,
                        title: "Venue Location",
                        focusNode: venueNode,
                        controller: venueLocation,
                        hintText: "Park/Stadium/Turf Name",
                        showBuilder: false,
                        prefixIcon: Align(
                          alignment: Alignment.center,
                          child: Icon(
                            venueNode.hasFocus
                                ? Icons.home
                                : Icons.home_outlined,
                            size: 20,
                            color: venueNode.hasFocus
                                ? ColorsConstants.defaultBlack
                                : ColorsConstants.defaultBlack.withValues(
                                    alpha: 0.3,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      InputField(
                        scrollPadding: false,
                        title: "Venue Area",
                        focusNode: areaNode,
                        controller: venueArea,
                        hintText: "Enter: Area, City, State",
                        showBuilder: false,
                        prefixIcon: Align(
                          alignment: Alignment.center,
                          child: Icon(
                            areaNode.hasFocus ? Icons.map : Icons.map_outlined,
                            size: 20,
                            color: areaNode.hasFocus
                                ? ColorsConstants.defaultBlack
                                : ColorsConstants.defaultBlack.withValues(
                                    alpha: 0.3,
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
                                    "Date",
                                    style: TextStyles.poppinsSemiBold.copyWith(
                                      fontSize: 12,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  InkWell(
                                    onTap: () async {
                                      await Methods.pickDate(
                                        context,
                                        _selectedDate,
                                        (pickedDate) async {
                                          if (pickedDate != null) {
                                            setState(() {
                                              _selectedDate = pickedDate;
                                            });
                                          }
                                        },
                                      );
                                    },
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: ColorsConstants.onSurfaceGrey
                                            .withValues(alpha: 0.2),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        labelStyle: TextStyles.poppinsMedium
                                            .copyWith(
                                              fontSize: 16,
                                              letterSpacing: -0.8,
                                              color:
                                                  ColorsConstants.defaultBlack,
                                            ),
                                      ),
                                      child: Text(
                                        _selectedDate == null
                                            ? "Select Date"
                                            : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                                        style: TextStyles.poppinsMedium
                                            .copyWith(
                                              fontSize: 16,
                                              letterSpacing: -0.8,
                                              color: _selectedDate == null
                                                  ? ColorsConstants.defaultBlack
                                                        .withValues(alpha: 0.3)
                                                  : ColorsConstants
                                                        .defaultBlack,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Time",
                                    style: TextStyles.poppinsSemiBold.copyWith(
                                      fontSize: 12,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  InkWell(
                                    onTap: () async {
                                      await Methods.pickTime(
                                        context,
                                        _selectedTime,
                                        (pickedTime) {
                                          if (pickedTime != null) {
                                            setState(() {
                                              _selectedTime = pickedTime;
                                            });
                                          }
                                        },
                                      );
                                    },
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: ColorsConstants.onSurfaceGrey
                                            .withValues(alpha: 0.2),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        labelStyle: TextStyles.poppinsMedium
                                            .copyWith(
                                              fontSize: 16,
                                              letterSpacing: -0.8,
                                              color:
                                                  ColorsConstants.defaultBlack,
                                            ),
                                      ),
                                      baseStyle: TextStyles.poppinsMedium
                                          .copyWith(
                                            fontSize: 16,
                                            letterSpacing: -0.8,
                                            color: _selectedTime == null
                                                ? ColorsConstants.defaultBlack
                                                      .withValues(alpha: 0.3)
                                                : ColorsConstants.defaultBlack,
                                          ),
                                      child: Text(
                                        _selectedTime == null
                                            ? "Select Time"
                                            : _selectedTime!.format(context),
                                        style: TextStyles.poppinsMedium
                                            .copyWith(
                                              fontSize: 16,
                                              letterSpacing: -0.8,
                                              color: _selectedTime == null
                                                  ? ColorsConstants.defaultBlack
                                                        .withValues(alpha: 0.3)
                                                  : ColorsConstants
                                                        .defaultBlack,
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
                                    ? "Format of Game"
                                    : "",
                                filled: true,
                                labelStyle: TextStyles.poppinsMedium.copyWith(
                                  fontSize: 16,
                                  letterSpacing: -0.8,
                                  color: ColorsConstants.defaultBlack
                                      .withValues(alpha: 0.2),
                                ),
                                fillColor: ColorsConstants.onSurfaceGrey
                                    .withValues(alpha: 0.2),
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
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Scorer",
                              style: TextStyles.poppinsSemiBold.copyWith(
                                fontSize: 12,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () async {
                                final thisScorer = await showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) =>
                                      SearchPlayersBottomSheet(
                                        initiallySelected: [],
                                        singleSelect: true,
                                      ),
                                );
                                if (thisScorer != null) {
                                  setState(() {
                                    scorer = thisScorer.last;
                                  });
                                }
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: ColorsConstants.onSurfaceGrey
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (scorer != null) ...[
                                      Text(
                                        scorer!.name,
                                        style: TextStyles.poppinsMedium
                                            .copyWith(
                                              fontSize: 16,
                                              letterSpacing: -0.8,
                                              color:
                                                  ColorsConstants.defaultBlack,
                                            ),
                                      ),
                                      Text(
                                        scorer!.playerId,
                                        style: TextStyles.poppinsMedium
                                            .copyWith(
                                              fontSize: 12,
                                              letterSpacing: -0.4,
                                              color: ColorsConstants
                                                  .defaultBlack
                                                  .withValues(alpha: 0.5),
                                            ),
                                      ),
                                    ],
                                    if (scorer == null)
                                      Text(
                                        "Select Scorer",
                                        style: TextStyles.poppinsMedium
                                            .copyWith(
                                              fontSize: 16,
                                              letterSpacing: -0.8,
                                              color: ColorsConstants
                                                  .defaultBlack
                                                  .withValues(alpha: 0.2),
                                            ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
