import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/account/presentation/blocs/cubits/cubit/account_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatTab extends StatelessWidget {
  final String label;
  final bool selected;
  final int index;

  const StatTab({
    super.key,
    required this.label,
    required this.selected,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AccountCubit>();
    return InkWell(
      onTap: () => cubit.changeStatisticsTab(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: selected ? ColorsConstants.accentOrange : Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(index == 0 ? 4 : 0),
            topRight: Radius.circular(index == 3 ? 4 : 0),
            bottomLeft: Radius.circular(index == 0 ? 4 : 0),
            bottomRight: Radius.circular(index == 3 ? 4 : 0),
          ),
        ),
        child: Text(
          label.toUpperCase(),
          style:
              (selected ? TextStyles.poppinsSemiBold : TextStyles.poppinsMedium)
                  .copyWith(
                    color: selected
                        ? ColorsConstants.defaultWhite
                        : ColorsConstants.defaultBlack,
                    fontSize: 10,
                    letterSpacing: -0.2,
                  ),
        ),
      ),
    );
  }
}
