import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/home/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.defaultWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            // if (widget.userEntity != null)
            const SizedBox(height: 24),
            SectionHeader(title: "Your Matches"),
            Container(
              height: 200,
              margin: EdgeInsets.only(top: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
              ),
              child: Center(
                child: Text(
                  "No Matches Yet",
                  style: TextStyles.poppinsRegular.copyWith(
                    fontSize: 16,
                    letterSpacing: -0.8,
                    color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SectionHeader(title: "From Your Circle"),
            Container(
              height: 200,
              margin: EdgeInsets.only(top: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
              ),
              child: Center(
                child: Text(
                  "No Matches Yet",
                  style: TextStyles.poppinsRegular.copyWith(
                    fontSize: 16,
                    letterSpacing: -0.8,
                    color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SectionHeader(title: "Explore"),
            Container(
              height: 200,
              margin: EdgeInsets.only(top: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
              ),
              child: Center(
                child: Text(
                  "No Matches Yet",
                  style: TextStyles.poppinsRegular.copyWith(
                    fontSize: 16,
                    letterSpacing: -0.8,
                    color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
