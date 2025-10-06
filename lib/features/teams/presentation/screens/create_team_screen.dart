import 'dart:io';

import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/common/textfield.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:cricklo/features/teams/presentation/blocs/cubits/CreateTeamCubit/create_team_cubit.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

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
  File? _pickedImage;
  File? _pickedLogo;

  Future<void> _pickLogo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,

        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Edit Image',
            toolbarColor: ColorsConstants.accentOrange,
            toolbarWidgetColor: ColorsConstants.defaultWhite,
            lockAspectRatio: false,
            cropStyle: CropStyle.circle,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.original,
            ],
          ),
          IOSUiSettings(
            title: 'Edit Image',
            cropStyle: CropStyle.circle,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.original,
            ],
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _pickedLogo = File(croppedFile.path);
        });
      }
    }
  }

  Future<void> _pickBanner() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,

        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Edit Image',
            toolbarColor: ColorsConstants.accentOrange,
            toolbarWidgetColor: ColorsConstants.defaultWhite,
            lockAspectRatio: false,

            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.original,
            ],
          ),

          IOSUiSettings(
            title: 'Edit Image',
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.original,
            ],
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _pickedImage = File(croppedFile.path);
        });
      }
    }
  }

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
    return BlocBuilder<CreateTeamCubit, CreateTeamState>(
      builder: (context, state) {
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
                    stateController.text.isEmpty,

                child: state.loading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: ColorsConstants.defaultWhite,
                        ),
                      )
                    : Text(
                        "Continue",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 16,
                          letterSpacing: -0.6,
                          color: ColorsConstants.defaultWhite,
                        ),
                      ),
                onPress: () {
                  final team = TeamEntity(
                    id: "",
                    name: nameController.text,
                    logoFile: _pickedLogo,
                    bannerFile: _pickedImage,
                    teamLogo: "",
                    teamBanner: "",
                    players: [],
                    location: LocationEntity(
                      area: areaController.text,
                      city: cityController.text,
                      state: stateController.text,
                      lat: 0,
                      lng: 0,
                    ),
                  );
                  print(team.players);
                  GoRouter.of(
                    context,
                  ).pushNamed(Routes.addPlayersToTeam, extra: team);
                },
              ),
            ),
          ),
          body: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                _pickedImage != null
                    ? Image.file(
                        _pickedImage!,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      )
                    : InkWell(
                        onTap: () => _pickBanner(),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          color: ColorsConstants.accentOrange.withValues(
                            alpha: 0.2,
                          ),
                          child: Center(
                            child: Text(
                              "Team Banner Here",
                              style: TextStyles.poppinsSemiBold.copyWith(
                                fontSize: 16,
                                letterSpacing: -0.8,
                                color: ColorsConstants.defaultBlack,
                              ),
                            ),
                          ),
                        ),
                      ),
                _pickedLogo != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ).copyWith(top: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            _pickedLogo!,
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
                          onTap: () => _pickLogo(),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: ColorsConstants.accentOrange
                                .withValues(alpha: 0.2),
                            child: Icon(
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
                  onSubmitted: (_) => Focus.of(context).requestFocus(areaNode),
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
                          : ColorsConstants.defaultBlack.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                InputField(
                  scrollPadding: false,
                  title: "Team Location - City",
                  onSubmitted: (_) => Focus.of(context).requestFocus(stateNode),
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
                          : ColorsConstants.defaultBlack.withValues(alpha: 0.3),
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
                          : ColorsConstants.defaultBlack.withValues(alpha: 0.3),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
