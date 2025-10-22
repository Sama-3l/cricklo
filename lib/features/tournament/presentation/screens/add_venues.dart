import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/common/textfield.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddVenuesPage extends StatefulWidget {
  const AddVenuesPage({
    super.key,
    required this.tournament,
    required this.onCreate,
  });

  final TournamentEntity tournament;
  final Function(TournamentEntity tournament) onCreate;

  @override
  State<AddVenuesPage> createState() => _AddVenuesPageState();
}

class _AddVenuesPageState extends State<AddVenuesPage> {
  final List<_VenueForm> _venues = [];

  void _addVenue() {
    setState(() {
      _venues.add(_VenueForm(onUpdate: _refresh));
    });
  }

  void _removeVenue() {
    setState(() {
      _venues.removeLast();
    });
  }

  void _refresh() => setState(() {});

  @override
  void initState() {
    super.initState();
    _addVenue(); // start with one venue by default
  }

  @override
  void dispose() {
    for (final v in _venues) {
      v.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColorsConstants.accentOrange,
        leading: IconButton(
          onPressed: () => GoRouter.of(context).pop(),
          icon: Icon(Icons.chevron_left, color: ColorsConstants.defaultWhite),
          iconSize: 32,
        ),
        title: Text(
          "Add Venues",
          style: TextStyles.poppinsMedium.copyWith(
            fontSize: 24,
            letterSpacing: -1.2,
            color: ColorsConstants.defaultWhite,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ).copyWith(bottom: 16),
        child: SizedBox(
          width: double.infinity,
          child: PrimaryButton(
            disabled:
                _venues[0].locationController.text.isEmpty ||
                _venues[0].areaController.text.split(', ').length < 3,

            child: Text(
              "Continue",
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 16,
                letterSpacing: -0.6,
                color: ColorsConstants.defaultWhite,
              ),
            ),
            onPress: () {
              final tournament = widget.tournament.copyWith(
                venues: _venues
                    .map(
                      (e) => Methods.getLocationEntity(
                        e.areaController.text,
                        e.locationController.text,
                      ),
                    )
                    .toList(),
              );
              GoRouter.of(context).push(
                Routes.addTournamentModerators,
                extra: [tournament, widget.onCreate],
              );
            },
          ),
        ),
      ),
      backgroundColor: ColorsConstants.defaultWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Venues",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 16,
                      letterSpacing: -0.8,
                    ),
                  ),
                  Row(
                    children: [
                      if (_venues.length > 1)
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: _removeVenue,
                        ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: _addVenue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ..._venues.asMap().entries.map(
              (e) => e.value.build(
                context,
                e.key == _venues.length - 1,
                e.key + 1,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _VenueForm {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final FocusNode locationNode = FocusNode();
  final FocusNode areaNode = FocusNode();
  final VoidCallback onUpdate;

  _VenueForm({required this.onUpdate}) {
    locationController.addListener(onUpdate);
    areaController.addListener(onUpdate);
  }

  void dispose() {
    locationController.dispose();
    areaController.dispose();
    locationNode.dispose();
    areaNode.dispose();
  }

  Widget build(BuildContext context, bool scrollPadding, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputField(
            scrollPadding: false,
            title: "Venue Location - $index",
            focusNode: locationNode,
            controller: locationController,
            hintText: "Park/Stadium/Turf Name",
            showBuilder: false,
            prefixIcon: Align(
              alignment: Alignment.center,
              child: Icon(
                locationNode.hasFocus ? Icons.home : Icons.home_outlined,
                size: 20,
                color: locationNode.hasFocus
                    ? ColorsConstants.defaultBlack
                    : ColorsConstants.defaultBlack.withValues(alpha: 0.3),
              ),
            ),
          ),
          const SizedBox(height: 16),
          InputField(
            scrollPadding: false,
            title: "Venue Area - $index",
            focusNode: areaNode,
            controller: areaController,
            hintText: "Enter: Area, City, State",
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
        ],
      ),
    );
  }
}
