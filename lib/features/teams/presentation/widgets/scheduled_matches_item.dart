import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/cupertino.dart';

class ScheduledMatchesItem extends StatelessWidget {
  const ScheduledMatchesItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: ColorsConstants.defaultWhite,
                  border: Border.all(color: ColorsConstants.defaultBlack),
                ),
                height: 64,
                width: 64,
                child: Icon(
                  CupertinoIcons.person_2_fill,
                  color: ColorsConstants.defaultBlack,
                  size: 24,
                ),
              ),
              Transform.translate(
                offset: Offset(32, 0),
                child: Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: ColorsConstants.defaultWhite,
                    border: Border.all(color: ColorsConstants.defaultBlack),
                  ),

                  child: Icon(
                    CupertinoIcons.person_2_fill,
                    color: ColorsConstants.defaultBlack,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Aviral All Star",
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 12,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                "Kerala Kings",
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 12,
                  letterSpacing: -0.5,
                ),
              ),
              // const Spacer(),
              Text(
                "10th Aug 2025 at 8:00AM",
                style: TextStyles.poppinsRegular.copyWith(
                  fontSize: 12,
                  letterSpacing: -0.5,
                  color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
