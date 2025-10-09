import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.title, required this.onTap});

  final Function() onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: ColorsConstants.accentOrange),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyles.poppinsSemiBold.copyWith(
            fontSize: 12,
            color: ColorsConstants.accentOrange,
            letterSpacing: -0.5,
          ),
        ),
      ),
    );
  }
}
