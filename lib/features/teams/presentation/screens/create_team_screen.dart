import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/common/textfield.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:cricklo/features/teams/presentation/blocs/cubits/CreateTeamCubit/create_team_cubit.dart';
import 'package:cricklo/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateTeamScreen extends StatefulWidget {
  const CreateTeamScreen({super.key, required this.user});

  final UserEntity user;

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode areaNode = FocusNode();
  final FocusNode cityNode = FocusNode();
  final FocusNode stateNode = FocusNode();

  @override
  void initState() {
    super.initState();

    nameController.addListener(_refresh);
    areaController.addListener(_refresh);
    cityController.addListener(_refresh);
    stateController.addListener(_refresh);

    nameFocus.addListener(_refresh);
    areaNode.addListener(_refresh);
    cityNode.addListener(_refresh);
    stateNode.addListener(_refresh);
  }

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CreateTeamCubit>(),
      child: BlocBuilder<CreateTeamCubit, CreateTeamState>(
        builder: (context, state) {
          final cubit = context.read<CreateTeamCubit>();
          return Scaffold(
            backgroundColor: ColorsConstants.defaultWhite,
            appBar: AppBar(
              backgroundColor: ColorsConstants.accentOrange,
              leading: IconButton(
                onPressed: () => GoRouter.of(context).pop(),
                icon: Icon(
                  Icons.chevron_left,
                  color: ColorsConstants.defaultWhite,
                ),
                iconSize: 32,
              ),
              title: Text(
                "Create Team",
                style: TextStyles.poppinsMedium.copyWith(
                  fontSize: 24,
                  letterSpacing: -1.2,
                  color: ColorsConstants.defaultWhite,
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  disabled:
                      nameController.text.isEmpty ||
                      areaController.text.isEmpty ||
                      cityController.text.isEmpty ||
                      stateController.text.isEmpty ||
                      state.logo == null ||
                      state.banner == null,

                  child: state.loading
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: ColorsConstants.defaultWhite,
                          ),
                        )
                      : Text(
                          "Create Team",
                          style: TextStyles.poppinsSemiBold.copyWith(
                            fontSize: 16,
                            letterSpacing: -0.6,
                            color: ColorsConstants.defaultWhite,
                          ),
                        ),
                  onPress: () async {
                    final teamLogo = await Methods.imageToBase64(state.logo!);
                    final teamBanner = await Methods.imageToBase64(
                      state.banner!,
                    );
                    final team = TeamEntity(
                      id: "",
                      name: nameController.text.trim(),
                      teamLogo: teamLogo,
                      teamBanner: teamBanner,
                      players: [],
                      location: LocationEntity(
                        area: areaController.text.trim(),
                        city: cityController.text.trim(),
                        state: stateController.text.trim(),
                        lat: 0,
                        lng: 0,
                      ),
                    );
                    cubit.createTeam(team, context);
                  },
                ),
              ),
            ),
            body: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  state.banner != null
                      ? Image.file(
                          state.banner!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        )
                      : InkWell(
                          onTap: () => cubit.pickBanner(),
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            color: ColorsConstants.accentOrange.withValues(
                              alpha: 0.2,
                            ),
                            child: Center(
                              child: state.bannerLoading
                                  ? SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        color: ColorsConstants.defaultBlack,
                                      ),
                                    )
                                  : Text(
                                      "Team Banner Here",
                                      style: TextStyles.poppinsSemiBold
                                          .copyWith(
                                            fontSize: 16,
                                            letterSpacing: -0.8,
                                            color: ColorsConstants.defaultBlack,
                                          ),
                                    ),
                            ),
                          ),
                        ),
                  state.logo != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ).copyWith(top: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              state.logo!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () => cubit.pickLogo(),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: ColorsConstants.accentOrange
                                  .withValues(alpha: 0.2),
                              child: state.logoLoading
                                  ? Center(
                                      child: SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: ColorsConstants.defaultBlack,
                                        ),
                                      ),
                                    )
                                  : Icon(
                                      Icons.people,
                                      size: 32,
                                      color: ColorsConstants.defaultBlack,
                                    ),
                            ),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: InputField(
                      scrollPadding: false,
                      title: "Team Name",
                      onSubmitted: (_) =>
                          Focus.of(context).requestFocus(areaNode),
                      focusNode: nameFocus,
                      controller: nameController,
                      hintText: "Chennai Super Queens",
                      showBuilder: false,
                      prefixIcon: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          nameFocus.hasFocus
                              ? Icons.people
                              : Icons.people_outline,
                          size: 20,
                          color: nameFocus.hasFocus
                              ? ColorsConstants.defaultBlack
                              : ColorsConstants.defaultBlack.withValues(
                                  alpha: 0.3,
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  InputField(
                    scrollPadding: false,
                    title: "Team Location - Area",
                    onSubmitted: (_) =>
                        Focus.of(context).requestFocus(areaNode),
                    focusNode: areaNode,
                    controller: areaController,
                    hintText: "Anna Nagar",
                    showBuilder: false,
                    prefixIcon: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        areaNode.hasFocus ? Icons.home : Icons.home_outlined,
                        size: 20,
                        color: areaNode.hasFocus
                            ? ColorsConstants.defaultBlack
                            : ColorsConstants.defaultBlack.withValues(
                                alpha: 0.3,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  InputField(
                    scrollPadding: false,
                    title: "Team Location - City",
                    onSubmitted: (_) =>
                        Focus.of(context).requestFocus(stateNode),
                    focusNode: cityNode,
                    controller: cityController,
                    hintText: "Chennai",
                    showBuilder: false,
                    prefixIcon: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        cityNode.hasFocus
                            ? Icons.location_on
                            : Icons.location_on_outlined,
                        size: 20,
                        color: cityNode.hasFocus
                            ? ColorsConstants.defaultBlack
                            : ColorsConstants.defaultBlack.withValues(
                                alpha: 0.3,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  InputField(
                    scrollPadding: true,
                    title: "Team Location - State",
                    onSubmitted: (_) => stateNode.unfocus(),
                    focusNode: stateNode,
                    controller: stateController,
                    hintText: "Tamil Nadu",
                    showBuilder: false,
                    prefixIcon: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        stateNode.hasFocus ? Icons.map : Icons.map_outlined,
                        size: 20,
                        color: stateNode.hasFocus
                            ? ColorsConstants.defaultBlack
                            : ColorsConstants.defaultBlack.withValues(
                                alpha: 0.3,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
