import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/global_variables.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/scorer/presentation/widgets/scorer_initial_screen_teams_header.dart';
import 'package:cricklo/features/teams/domain/entities/search_user_entity.dart';
import 'package:cricklo/features/teams/presentation/widgets/search_players_bottom_sheet.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ModeratorMatchCenter extends StatefulWidget {
  const ModeratorMatchCenter({
    super.key,
    required this.matchEntity,
    required this.tournamentEntity,
    required this.onSubmit,
  });

  final MatchEntity matchEntity;
  final TournamentEntity tournamentEntity;
  final Function(
    BuildContext context,
    String matchId,
    Map<String, dynamic> scorer,
    String venueId,
    DateTime date,
    TimeOfDay time,
  )
  onSubmit;

  @override
  State<ModeratorMatchCenter> createState() => _ModeratorMatchCenterState();
}

class _ModeratorMatchCenterState extends State<ModeratorMatchCenter> {
  String? venueLocation;

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedFormat;
  SearchUserEntity? scorer;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      if ((widget.matchEntity.scorer["name"] as String).isNotEmpty) {
        _selectedDate = widget.matchEntity.dateAndTime;
        _selectedTime = TimeOfDay.fromDateTime(widget.matchEntity.dateAndTime);
      }
      _selectedFormat = widget.matchEntity.matchType.matchType;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Loading $loading");
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
          GlobalVariables.user != null &&
                  widget.matchEntity.scorer["profileId"] ==
                      GlobalVariables.user!.profileId
              ? "Start Match"
              : "Match Details",
          style: TextStyles.poppinsMedium.copyWith(
            fontSize: 24,
            letterSpacing: -1.2,
            color: ColorsConstants.defaultWhite,
          ),
        ),

        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ).copyWith(top: 12, bottom: 16),
        color: ColorsConstants.defaultWhite,
        width: double.infinity,
        child: PrimaryButton(
          disabled:
              _selectedDate == null ||
              _selectedTime == null ||
              venueLocation == null ||
              scorer == null,
          child: loading
              ? SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: ColorsConstants.defaultWhite,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  "Schedule Match",
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 16,
                    letterSpacing: -0.6,
                    color: ColorsConstants.defaultWhite,
                  ),
                ),
          onPress: () async {
            setState(() {
              loading = true;
            });
            final response = await widget.onSubmit(
              context,
              widget.matchEntity.matchID,
              {"profileId": scorer!.playerId, "name": scorer!.name},
              venueLocation!,
              _selectedDate!,
              _selectedTime!,
            );
            setState(() {
              loading = false;
            });
            if (response as bool? ?? false) {
              GoRouter.of(context).pop();
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              children: [
                ScorerInitialScreenTeamsHeader(matchEntity: widget.matchEntity),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Venue * ",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        dropdownColor: ColorsConstants.defaultWhite,
                        initialValue: venueLocation,
                        decoration: InputDecoration(
                          labelText: venueLocation == null
                              ? "Venue of Match"
                              : "",
                          filled: true,
                          labelStyle: TextStyles.poppinsMedium.copyWith(
                            fontSize: 16,
                            letterSpacing: -0.8,
                            color: ColorsConstants.defaultBlack.withValues(
                              alpha: 0.2,
                            ),
                          ),
                          fillColor: ColorsConstants.onSurfaceGrey,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: widget.tournamentEntity.venues
                            .map(
                              (f) => DropdownMenuItem(
                                value: f.id,
                                child: Text(
                                  "${f.location != null && f.location!.isNotEmpty ? "${f.location}, " : ""}${f.location != null && f.location!.isNotEmpty ? " ${f.city}, " : "${f.city}, "}${f.state}",
                                  style: TextStyles.poppinsMedium.copyWith(
                                    fontSize: 16,
                                    letterSpacing: -0.8,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            venueLocation = val;
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
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date * ",
                              style: TextStyles.poppinsSemiBold.copyWith(
                                fontSize: 12,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () async {
                                await Methods.pickDate(context, _selectedDate, (
                                  pickedDate,
                                ) async {
                                  if (pickedDate != null) {
                                    setState(() {
                                      _selectedDate = pickedDate;
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
                                  _selectedDate == null
                                      ? "Select Date"
                                      : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                                  style: TextStyles.poppinsMedium.copyWith(
                                    fontSize: 16,
                                    letterSpacing: -0.8,
                                    color: _selectedDate == null
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
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Time *",
                              style: TextStyles.poppinsSemiBold.copyWith(
                                fontSize: 12,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () async {
                                await Methods.pickTime(context, _selectedTime, (
                                  pickedTime,
                                ) {
                                  if (pickedTime != null) {
                                    setState(() {
                                      _selectedTime = pickedTime;
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
                                baseStyle: TextStyles.poppinsMedium.copyWith(
                                  fontSize: 16,
                                  letterSpacing: -0.8,
                                  color: _selectedTime == null
                                      ? ColorsConstants.defaultBlack.withValues(
                                          alpha: 0.3,
                                        )
                                      : ColorsConstants.defaultBlack,
                                ),
                                child: Text(
                                  _selectedTime == null
                                      ? "Select Time"
                                      : _selectedTime!.format(context),
                                  style: TextStyles.poppinsMedium.copyWith(
                                    fontSize: 16,
                                    letterSpacing: -0.8,
                                    color: _selectedTime == null
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
                        "Format",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: ColorsConstants.onSurfaceGrey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _selectedFormat!,
                          style: TextStyles.poppinsMedium.copyWith(
                            fontSize: 16,
                            letterSpacing: -0.8,
                            color: ColorsConstants.defaultBlack,
                          ),
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
                      Row(
                        children: [
                          Text(
                            "Scorer *",
                            style: TextStyles.poppinsSemiBold.copyWith(
                              fontSize: 12,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            widget.matchEntity.scorer["inviteStatus"] != null
                                ? "INVITE ${widget.matchEntity.scorer["inviteStatus"]}"
                                : "",
                            style: TextStyles.poppinsSemiBold.copyWith(
                              fontSize: 12,
                              letterSpacing: -0.5,
                              color: ColorsConstants.accentOrange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () async {
                          final thisScorer = await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SearchPlayersBottomSheet(
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
                            color: ColorsConstants.onSurfaceGrey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (scorer != null) ...[
                                Text(
                                  scorer!.name,
                                  style: TextStyles.poppinsMedium.copyWith(
                                    fontSize: 16,
                                    letterSpacing: -0.8,
                                    color: ColorsConstants.defaultBlack,
                                  ),
                                ),
                                Text(
                                  scorer!.playerId,
                                  style: TextStyles.poppinsMedium.copyWith(
                                    fontSize: 12,
                                    letterSpacing: -0.4,
                                    color: ColorsConstants.defaultBlack
                                        .withValues(alpha: 0.5),
                                  ),
                                ),
                              ],
                              if (scorer == null)
                                Text(
                                  "Select Scorer",
                                  style: TextStyles.poppinsMedium.copyWith(
                                    fontSize: 16,
                                    letterSpacing: -0.8,
                                    color: ColorsConstants.defaultBlack
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
  }
}
