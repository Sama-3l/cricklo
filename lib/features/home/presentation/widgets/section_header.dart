import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/cupertino.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.showIcon = true});

  final String title;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyles.poppinsSemiBold.copyWith(
            fontSize: 20,
            letterSpacing: -1.2,
            color: ColorsConstants.defaultBlack,
          ),
        ),
        const Spacer(),
        if (showIcon) Icon(CupertinoIcons.chevron_right, size: 20),
      ],
    );
  }
}
