import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/scorer/domain/entities/match_center_entity.dart';
import 'package:cricklo/features/scorer/presentation/widgets/commentary_over_card.dart';
import 'package:flutter/material.dart';

class CommentaryScreen extends StatefulWidget {
  final MatchCenterEntity matchCenterEntity;

  const CommentaryScreen({super.key, required this.matchCenterEntity});

  @override
  State<CommentaryScreen> createState() => _CommentaryScreenState();
}

class _CommentaryScreenState extends State<CommentaryScreen> {
  int selectedInnings = 0;

  @override
  Widget build(BuildContext context) {
    final innings = widget.matchCenterEntity.innings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInningsToggle(widget.matchCenterEntity),
        const SizedBox(height: 8),
        Expanded(
          child: selectedInnings == 1 && innings.length < 2
              ? Center(child: Text("No Data Yet"))
              : selectedInnings == 0 &&
                    innings[selectedInnings].oversData.isEmpty
              ? Center(child: Text("No Data Yet"))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  itemCount: innings[selectedInnings].oversData.length,
                  itemBuilder: (context, index) {
                    final over = innings[selectedInnings].oversData.reversed
                        .toList()[index];
                    return CommentaryOverCard(over: over);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildInningsToggle(MatchCenterEntity match) {
    // final innings = match.innings;
    // final isTestMatch = match.matchType.matchType.toLowerCase() == "test";

    // // For non-Test matches → always show 2 innings
    // final totalInnings = isTestMatch ? innings.length : 2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () => setState(() => selectedInnings = 0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: selectedInnings == 0
                      ? ColorsConstants.accentOrange
                      : Colors.grey.shade300,
                ),
                child: Center(
                  child: Text(
                    "Innings 1",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 16,
                      letterSpacing: -0.8,
                      color: selectedInnings == 0
                          ? ColorsConstants.defaultWhite
                          : ColorsConstants.defaultBlack,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: InkWell(
              onTap: () => setState(() => selectedInnings = 1),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: selectedInnings == 1
                      ? ColorsConstants.accentOrange
                      : Colors.grey.shade300,
                ),
                child: Center(
                  child: Text(
                    "Innings 2",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 16,
                      letterSpacing: -0.8,
                      color: selectedInnings == 1
                          ? ColorsConstants.defaultWhite
                          : ColorsConstants.defaultBlack,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
