import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsButton extends StatelessWidget {
  final VoidCallback onPressed;
  final int unread;
  const NotificationsButton({
    super.key,
    required this.onPressed,
    required this.unread,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: Icon(
            CupertinoIcons.bell_fill,
            color: ColorsConstants.defaultWhite,
          ),
          onPressed: onPressed,
        ),
        if (unread > 0)
          Positioned(
            right: 4,
            top: 2,
            child: CircleAvatar(
              backgroundColor: ColorsConstants.defaultBlack,
              radius: 10,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(9),
              // ),
              // constraints: const BoxConstraints(
              //   minWidth: 18,
              //   minHeight: 18,
              // ),
              // alignment: Alignment.center, // <- centers the child
              child: Text(
                unread > 9 ? '9+' : '$unread',
                style: TextStyles.poppinsRegular.copyWith(
                  color: ColorsConstants.defaultWhite,
                  fontSize: 10, // slightly bigger for better centering
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
