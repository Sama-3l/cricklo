import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/cupertino.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.subTitle,
    this.showIcon = true,
  });

  final String title;
  final String? subTitle;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              title,
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 20,
                letterSpacing: -1.2,
                color: ColorsConstants.defaultBlack,
              ),
            ),
            if (subTitle != null)
              Text(
                subTitle!,
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 14,
                  letterSpacing: -0.6,
                  color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
                ),
              ),
          ],
        ),
        const Spacer(),
        if (showIcon) Icon(CupertinoIcons.chevron_right, size: 20),
      ],
    );
  }
}
