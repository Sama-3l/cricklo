import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/account/presentation/screens/account.dart';
import 'package:cricklo/features/home/presentation/screens/home.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/mainapp/presentation/blocs/cubits/MainAppCubit/main_app_cubit.dart';
import 'package:cricklo/features/mainapp/presentation/widgets/custom_tab_bar.dart';
import 'package:cricklo/features/matches/presentation/screens/matches.dart';
import 'package:cricklo/features/notifications/presentation/blocs/blocs/NotificationBloc/notification_bloc.dart';
import 'package:cricklo/features/notifications/presentation/screens/notifications_button.dart';
import 'package:cricklo/injection_container.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ContentView extends StatefulWidget {
  const ContentView({super.key, this.currUser});

  final UserEntity? currUser;

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
                    strokeWidth: 2.5,
                  ),
                ),
              ),
            );
          }

          return Scaffold(
            backgroundColor: ColorsConstants.defaultWhite,
            appBar: AppBar(
              iconTheme: IconThemeData(color: ColorsConstants.defaultWhite),
              backgroundColor: ColorsConstants.accentOrange,
              title: Text(
                Methods.getMainAppPageTitle(state.currentIndex),
                style: TextStyles.poppinsMedium.copyWith(
                  fontSize: 24,
                  letterSpacing: -1.2,
                  color: ColorsConstants.defaultWhite,
                ),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: NotificationsButton(
                    onPressed: () {
                      context.read<NotificationBloc>().add(
                        NotificationReadAll(),
                      );
                      GoRouter.of(context).pushNamed(Routes.notifications);
                    },
                  ),
                ),
              ],
            ),

            drawer: _buildDrawer(context, cubit, state),

            body: PageView(
              controller: _pageController,
              onPageChanged: (index) => cubit.goToTab(index, context),
              children: [
                HomePage(userEntity: state.user),
                MatchesPage(),
                const Center(child: Text('Tournaments')),
                AccountPage(userEntity: state.user),
              ],
            ),

            bottomNavigationBar: CustomTabBar(
              selectedTab: (index) {
                cubit.goToTab(index, context);
                if (!(index == 3 && state.user == null)) {
                  _pageController.jumpToPage(index);
                }
              },
              selectedIndex: state.currentIndex,
            ),
          );
        },
      ),
    );
  }

  Widget _buildDrawer(
    BuildContext context,
    MainAppCubit cubit,
    MainAppState state,
  ) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: ColorsConstants.accentOrange),
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
        ],
      ),
    );
  }
}
