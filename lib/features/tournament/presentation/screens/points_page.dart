import 'package:cricklo/core/utils/common/secondary_button.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/home/presentation/widgets/section_header.dart';
import 'package:cricklo/features/tournament/presentation/widgets/points_table.dart';
import 'package:flutter/material.dart';

class PointsPage extends StatelessWidget {
  const PointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(flex: 2),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: SecondaryButton(onTap: () {}, title: "Create Group"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: 4,
              separatorBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Divider(
                  color: ColorsConstants.onSurfaceGrey,
                  thickness: 2,
                ),
              ),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SectionHeader(
                            title: "Group A",
                            showIcon: false,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: ColorsConstants.defaultBlack,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              Icons.edit,
                              color: ColorsConstants.defaultBlack,
                              size: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    PointsTable(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
