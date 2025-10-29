import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/home/presentation/widgets/match_tile.dart';
import 'package:cricklo/features/home/presentation/widgets/section_header.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:flutter/material.dart';

class EntityMatchesPage extends StatefulWidget {
  const EntityMatchesPage({
    super.key,
    required this.matches,
    this.loading = false,
    this.title = "Your Matches",
    this.removePadding = false,
    this.whiteTile = false,
  });

  final List<MatchEntity> matches;
  final bool loading;
  final String title;
  final bool removePadding;
  final bool whiteTile;

  @override
  State<EntityMatchesPage> createState() => _EntityMatchesPageState();
}

class _EntityMatchesPageState extends State<EntityMatchesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.whiteTile
          ? ColorsConstants.defaultWhite
          : ColorsConstants.onSurfaceGrey,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: widget.removePadding ? 0 : 16.0,
        ),
        child: widget.matches.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "No Matches Yet",
                      style: TextStyles.poppinsRegular.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.defaultBlack.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0, top: 24),
                    child: SectionHeader(title: widget.title, showIcon: false),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemCount: widget.matches.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(
                          bottom: index == widget.matches.length - 1 ? 24 : 0,
                        ),
                        child: MatchTile(
                          matchEntity: widget.matches[index],
                          whiteTile: !widget.whiteTile,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
