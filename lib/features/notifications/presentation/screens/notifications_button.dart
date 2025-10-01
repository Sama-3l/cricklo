import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/notifications/presentation/blocs/blocs/NotificationBloc/notification_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsButton extends StatelessWidget {
  final VoidCallback onPressed;
  const NotificationsButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        final unread = state.unreadCount;

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
      },
    );
  }
}
