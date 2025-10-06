import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/common/textfield.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/teams/presentation/widgets/search_players_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateMatch extends StatefulWidget {
  const CreateMatch({super.key});

  @override
  State<CreateMatch> createState() => _CreateMatchState();
}

class _CreateMatchState extends State<CreateMatch> {
  final TextEditingController venueLocation = TextEditingController();
  final TextEditingController venueArea = TextEditingController();

  final FocusNode venueNode = FocusNode();
  final FocusNode areaNode = FocusNode();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedFormat;
  String? scorerA;
  String? scorerB;

  void _refresh() => setState(() {});

  @override
  void initState() {
    super.initState();
    venueLocation.addListener(_refresh);
    venueArea.addListener(_refresh);
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
          "Create Match",
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
              venueLocation.text.isEmpty ||
              venueArea.text.isEmpty ||
              scorerA == null ||
              scorerB == null ||
              _selectedDate == null ||
              _selectedTime == null ||
              _selectedFormat == null,
          child: Text(
            "Create Match",
            style: TextStyles.poppinsSemiBold.copyWith(
              fontSize: 16,
              letterSpacing: -0.6,
              color: ColorsConstants.defaultWhite,
            ),
          ),
          onPress: () {},
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
                    Column(
                      children: [
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
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => SearchPlayersBottomSheet(
                                initiallySelected: [],
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(40),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: ColorsConstants.accentOrange
                                .withValues(alpha: 0.2),
                            child: Icon(
                              Icons.add,
                              size: 24,
                              color: ColorsConstants.defaultBlack,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
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
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => SearchPlayersBottomSheet(
                                initiallySelected: [],
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(40),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: ColorsConstants.accentOrange
                                .withValues(alpha: 0.2),
                            child: Icon(
                              Icons.add,
                              size: 24,
                              color: ColorsConstants.defaultBlack,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Scorer - Team A",
                              style: TextStyles.poppinsSemiBold.copyWith(
                                fontSize: 12,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              dropdownColor: ColorsConstants.defaultWhite,
                              initialValue: scorerA,
                              decoration: InputDecoration(
                                labelText: scorerA == null ? "Scorer" : "",
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
                                  scorerA = val;
                                });
                              },
                              validator: (val) =>
                                  val == null ? "Select a match format" : null,
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
                              "Scorer - Team B",
                              style: TextStyles.poppinsSemiBold.copyWith(
                                fontSize: 12,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              dropdownColor: ColorsConstants.defaultWhite,
                              initialValue: scorerB,
                              decoration: InputDecoration(
                                labelText: scorerB == null ? "Scorer" : "",
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
                                  scorerB = val;
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
                      venueNode.hasFocus ? Icons.home : Icons.home_outlined,
                      size: 20,
                      color: venueNode.hasFocus
                          ? ColorsConstants.defaultBlack
                          : ColorsConstants.defaultBlack.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                InputField(
                  scrollPadding: false,
                  title: "Venue Area",
                  focusNode: areaNode,
                  controller: venueArea,
                  hintText: "Park/Stadium/Turf Name",
                  showBuilder: false,
                  prefixIcon: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      areaNode.hasFocus ? Icons.map : Icons.map_outlined,
                      size: 20,
                      color: areaNode.hasFocus
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
                              "Date",
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
                            color: ColorsConstants.defaultBlack.withValues(
                              alpha: 0.2,
                            ),
                          ),
                          fillColor: ColorsConstants.onSurfaceGrey.withValues(
                            alpha: 0.2,
                          ),
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
                            _selectedFormat = val;
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
        ),
      ),
    );
  }
}
