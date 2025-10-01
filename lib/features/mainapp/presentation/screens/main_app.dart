import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/account/presentation/screens/account.dart';
import 'package:cricklo/features/home/presentation/screens/home.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/mainapp/presentation/blocs/cubits/MainAppCubit/main_app_cubit.dart';
import 'package:cricklo/features/mainapp/presentation/widgets/custom_tab_bar.dart';
import 'package:cricklo/features/notifications/presentation/blocs/blocs/NotificationBloc/notification_bloc.dart';
import 'package:cricklo/features/notifications/presentation/screens/notifications_button.dart';
import 'package:cricklo/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContentView extends StatefulWidget {
  const ContentView({super.key, this.currUser});

  final UserEntity? currUser;

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MainAppCubit>()..init(widget.currUser),
      child: BlocBuilder<MainAppCubit, MainAppState>(
        builder: (context, state) {
          final cubit = context.read<MainAppCubit>();
          if (state.loading) {
            return Scaffold(
              backgroundColor: ColorsConstants.defaultWhite,
              body: Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: ColorsConstants.accentOrange,
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            backgroundColor: ColorsConstants.defaultWhite,
            appBar: AppBar(
              backgroundColor: ColorsConstants.accentOrange,
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon: Icon(Icons.menu, color: ColorsConstants.defaultWhite),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
              title: Text(
                _getTitle(state.currentIndex),
                style: TextStyles.poppinsMedium.copyWith(
                  fontSize: 24,
                  letterSpacing: -1.2,
                  color: ColorsConstants.defaultWhite,
                ),
              ),
              actions: [
                NotificationsButton(
                  onPressed: () {
                    context.read<NotificationBloc>().add(NotificationReadAll());
                  },
                ),
              ],
              centerTitle: true,
            ),

            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: ColorsConstants.accentOrange,
                    ),
                    child: Text(
                      'Account Options here',
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.defaultBlack,
                      ),
                    ),
                  ),
                  if (state.user != null)
                    ListTile(
                      onTap: () => cubit.logout(context),
                      title: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: ColorsConstants.warningRed,
                            size: 16,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Logout",
                            style: TextStyles.poppinsSemiBold.copyWith(
                              color: ColorsConstants.warningRed,
                              fontSize: 16,
                              letterSpacing: -0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  // ListTile(title: Text('Item 2')),
                ],
              ),
            ),

            body: IndexedStack(
              index: state.currentIndex,
              children: [
                Center(child: HomePage(userEntity: state.user)),
                Center(child: Text('Matches')),
                Center(child: Text('Tournaments')),
                Center(child: AccountPage(userEntity: state.user)),
              ],
            ),
            bottomNavigationBar: CustomTabBar(),
          );
        },
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Matches';
      case 2:
        return 'Tournaments';
      case 3:
        return 'Account';
      default:
        return '';
    }
  }
}
