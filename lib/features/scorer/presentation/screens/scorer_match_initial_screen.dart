import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/common/textfield.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/scorer/presentation/widgets/scorer_dialogs.dart';
import 'package:cricklo/features/scorer/presentation/widgets/scorer_initial_screen_teams_header.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScorerMatchInitialScreen extends StatefulWidget {
  const ScorerMatchInitialScreen({super.key, required this.matchEntity});

  final MatchEntity matchEntity;

  @override
  State<ScorerMatchInitialScreen> createState() =>
      _ScorerMatchInitialScreenState();
}

class _ScorerMatchInitialScreenState extends State<ScorerMatchInitialScreen> {
  final TextEditingController venueLocation = TextEditingController();
  final TextEditingController venueArea = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedFormat;

  @override
  void initState() {
    super.initState();
    setState(() {
      venueLocation.text = widget.matchEntity.location.location ?? "";
      venueArea.text =
          "${widget.matchEntity.location.area}, ${widget.matchEntity.location.city}, ${widget.matchEntity.location.state}";
      _selectedDate = widget.matchEntity.dateAndTime;
      _selectedTime = TimeOfDay.fromDateTime(widget.matchEntity.dateAndTime);
      _selectedFormat = widget.matchEntity.matchType.matchType;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          "Start Match",
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
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 12),
        color: ColorsConstants.defaultWhite,
        width: double.infinity,
        child: PrimaryButton(
          disabled:
              widget.matchEntity.teamA.inviteStatus! == "PENDING" ||
              widget.matchEntity.teamB.inviteStatus! == "PENDING",
          child: Text(
            "Start Match",
            style: TextStyles.poppinsSemiBold.copyWith(
              fontSize: 16,
              letterSpacing: -0.6,
              color: ColorsConstants.defaultWhite,
            ),
          ),
          onPress: () async {
            final result = await showTossDialog(
              context,
              teamAId: widget.matchEntity.teamA.id,
              teamBId: widget.matchEntity.teamB.id,
              teamAName: widget.matchEntity.teamA.name,
              teamALogo: widget.matchEntity.teamA.teamLogo,
              teamBName: widget.matchEntity.teamB.name,
              teamBLogo: widget.matchEntity.teamB.teamLogo,
            );

            if (result != null) {
              final winner = result["winner"];
              final choice = result["choice"];

              print("Winner: $winner | Choice: $choice");

              widget.matchEntity.tossWinner = winner;
              widget.matchEntity.tossChoice = choice!.split(" ")[0] == "Bat"
                  ? TossChoice.batting
                  : TossChoice.bowling;

              GoRouter.of(
                context,
              ).pushNamed(Routes.scorerMatchCenter, extra: widget.matchEntity);
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
                InputField(
                  readOnly: true,
                  scrollPadding: false,
                  title: "Venue Location",
                  controller: venueLocation,
                  hintText: "Park/Stadium/Turf Name",
                  showBuilder: false,
                  prefixIcon: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.home,
                      size: 20,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                InputField(
                  readOnly: true,
                  scrollPadding: false,
                  title: "Venue Area",
                  controller: venueArea,
                  hintText: "Park/Stadium/Turf Name",
                  showBuilder: false,
                  prefixIcon: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.map,
                      size: 20,
                      color: ColorsConstants.defaultBlack,
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
                              onTap: () async {},
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ColorsConstants.onSurfaceGrey
                                      .withValues(alpha: 0.2),
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
                              "Time",
                              style: TextStyles.poppinsSemiBold.copyWith(
                                fontSize: 12,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () async {},
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ColorsConstants.onSurfaceGrey
                                      .withValues(alpha: 0.2),
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
                          color: ColorsConstants.onSurfaceGrey.withValues(
                            alpha: 0.2,
                          ),
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
                      Text(
                        "Scorer",
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
                          color: ColorsConstants.onSurfaceGrey.withValues(
                            alpha: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.matchEntity.scorer["name"],
                              style: TextStyles.poppinsMedium.copyWith(
                                fontSize: 16,
                                letterSpacing: -0.8,
                                color: ColorsConstants.defaultBlack,
                              ),
                            ),
                            Text(
                              widget.matchEntity.scorer["profileId"],
                              style: TextStyles.poppinsMedium.copyWith(
                                fontSize: 12,
                                letterSpacing: -0.4,
                                color: ColorsConstants.defaultBlack.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                          ],
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
