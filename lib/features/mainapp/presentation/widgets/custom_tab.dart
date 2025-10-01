import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/mainapp/presentation/blocs/cubits/MainAppCubit/main_app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({
    super.key,
    required this.title,
    required this.index,
    required this.selectedIcon,
    required this.unselectedIcon,
  });

  final String title;
  final int index;
  final IconData selectedIcon;
  final IconData unselectedIcon;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MainAppCubit>();
    return InkWell(
      onTap: () => cubit.goToTab(index, context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            cubit.state.currentIndex == index ? selectedIcon : unselectedIcon,
            size: 24,
            color: cubit.state.currentIndex == index
                ? ColorsConstants.accentOrange
                : ColorsConstants.defaultBlack.withValues(alpha: 0.3),
          ),
          Text(
            title,
            style: TextStyles.poppinsMedium.copyWith(
              fontSize: 12,
              color: cubit.state.currentIndex == index
                  ? ColorsConstants.accentOrange
                  : ColorsConstants.defaultBlack.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }
}
