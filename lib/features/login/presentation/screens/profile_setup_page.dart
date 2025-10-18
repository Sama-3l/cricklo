import 'dart:io';

import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/common/textfield.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController area = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  String? emailError;

  final FocusNode _nameNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _areaNode = FocusNode();
  final FocusNode _cityNode = FocusNode();
  final FocusNode _stateNode = FocusNode();

  File? logo;

  @override
  void initState() {
    super.initState();

    name.addListener(_checkIfUpdate);
    email.addListener(_checkIfUpdate);
    area.addListener(_checkIfUpdate);
    city.addListener(_checkIfUpdate);
    state.addListener(_checkIfUpdate);

    // add listeners to refresh the widget tree when focus changes
    _nameNode.addListener(_refresh);
    _emailNode.addListener(_refresh);
    _areaNode.addListener(_refresh);
    _cityNode.addListener(_refresh);
    _stateNode.addListener(_refresh);
  }

  void _checkIfUpdate() {
    if (name.text.isNotEmpty &&
        area.text.isNotEmpty &&
        email.text.isNotEmpty &&
        city.text.isNotEmpty &&
        state.text.isNotEmpty) {
      _refresh();
    }
  }

  void validateEmail(String value) {
    value = value.trim();
    setState(() {
      if (value.isEmpty) {
        emailError = "Email cannot be empty";
      } else if (!value.endsWith("@gmail.com")) {
        emailError = "Please enter a valid Gmail address";
      } else if (value.contains(' ')) {
        emailError = "Remove all spaces";
      } else {
        emailError = null;
      }
    });
  }

  void _refresh() => setState(() {});

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    area.dispose();
    city.dispose();
    state.dispose();
    _nameNode.dispose();
    _emailNode.dispose();
    _areaNode.dispose();
    _cityNode.dispose();
    _stateNode.dispose();
    super.dispose();
  }

  Future<void> pickLogo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      // final croppedFile = await ImageCropper().cropImage(
      //   sourcePath: pickedFile.path,

      //   uiSettings: [
      //     AndroidUiSettings(
      //       toolbarTitle: 'Edit Image',
      //       toolbarColor: ColorsConstants.accentOrange,
      //       toolbarWidgetColor: ColorsConstants.defaultWhite,
      //       lockAspectRatio: false,
      //       cropStyle: CropStyle.circle,
      //       aspectRatioPresets: [
      //         CropAspectRatioPreset.square,
      //         CropAspectRatioPreset.ratio16x9,
      //         CropAspectRatioPreset.original,
      //       ],
      //     ),
      //     IOSUiSettings(
      //       title: 'Edit Image',
      //       cropStyle: CropStyle.circle,
      //       aspectRatioPresets: [
      //         CropAspectRatioPreset.square,
      //         CropAspectRatioPreset.ratio16x9,
      //         CropAspectRatioPreset.original,
      //       ],
      //     ),
      //   ],
      // );

      if (pickedFile != null) {
        setState(() {
          logo = File(pickedFile.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => GoRouter.of(context).pop(),
          icon: Icon(CupertinoIcons.back, size: 24),
        ),
        title: Text(
          "Complete Your Profile",
          style: TextStyles.poppinsSemiBold.copyWith(
            fontSize: 16,
            letterSpacing: -0.8,
            color: ColorsConstants.defaultBlack,
          ),
        ),
        actions: [],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ).copyWith(bottom: 16),
        child: SizedBox(
          width: double.infinity,
          child: PrimaryButton(
            disabled:
                name.text.isEmpty ||
                email.text.isEmpty ||
                area.text.isEmpty ||
                city.text.isEmpty ||
                state.text.isEmpty,
            child: Text(
              "Next",
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 16,
                letterSpacing: -0.6,
                color: ColorsConstants.defaultWhite,
              ),
            ),
            onPress: () {
              validateEmail(email.text);
              String emailText = email.text.trim();
              if (emailError == null) {
                GoRouter.of(context).pushNamed(
                  Routes.onboardingScreenOne,
                  extra: UserEntity(
                    profilePicFile: logo,
                    profileId: "",
                    profilePic: "",
                    unreadNotifications: 0,
                    phoneNumber: widget.phoneNumber,
                    name: name.text,
                    email: emailText,
                    location: LocationEntity(
                      area: area.text,
                      city: city.text,
                      state: state.text,
                      lat: 0,
                      lng: 0,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: InkWell(
                  onTap: () => pickLogo(),
                  borderRadius: BorderRadius.circular(48),
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: ColorsConstants.accentOrange.withValues(
                      alpha: 0.2,
                    ),
                    backgroundImage: logo != null ? FileImage(logo!) : null,
                    child: logo == null
                        ? Icon(
                            CupertinoIcons.person_fill,
                            size: 24,
                            color: ColorsConstants.defaultBlack,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Profile Pic",
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 12,
                  letterSpacing: -0.5,
                  color: ColorsConstants.defaultBlack,
                ),
              ),
              const SizedBox(height: 16),

              // NAME FIELD
              InputField(
                scrollPadding: false,
                title: "Name",
                focusNode: _nameNode,
                onSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_emailNode),
                // FocusScope.of(context).requestFocus(_emailNode),
                controller: name,
                hintText: "Siddhartha",
                showBuilder: false,
                prefixIcon: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    _nameNode.hasFocus ? Icons.person : Icons.person_outline,
                    size: 20,
                    color: _nameNode.hasFocus
                        ? ColorsConstants.defaultBlack
                        : ColorsConstants.defaultBlack.withValues(alpha: 0.3),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // EMAIL FIELD
              InputField(
                scrollPadding: false,
                title: "Email",
                focusNode: _emailNode,
                textCapitalization: TextCapitalization.none,
                errorText: emailError,
                onSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_areaNode),
                controller: email,
                hintText: "example@gmail.com",
                showBuilder: false,
                prefixIcon: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    _emailNode.hasFocus ? Icons.email : Icons.email_outlined,
                    size: 20,
                    color: _emailNode.hasFocus
                        ? ColorsConstants.defaultBlack
                        : ColorsConstants.defaultBlack.withValues(alpha: 0.3),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // AREA FIELD
              InputField(
                scrollPadding: false,
                title: "Area",
                focusNode: _areaNode,
                onSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_cityNode),
                controller: area,
                hintText: "Vishal Khand",
                showBuilder: false,
                prefixIcon: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    _areaNode.hasFocus ? Icons.home : Icons.home_outlined,
                    size: 20,
                    color: _areaNode.hasFocus
                        ? ColorsConstants.defaultBlack
                        : ColorsConstants.defaultBlack.withValues(alpha: 0.3),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // CITY FIELD
              InputField(
                title: "City",
                scrollPadding: false,
                focusNode: _cityNode,
                onSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_stateNode),
                controller: city,
                hintText: "Lucknow",
                showBuilder: false,
                prefixIcon: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    _cityNode.hasFocus
                        ? Icons.location_on
                        : Icons.location_on_outlined,
                    size: 20,
                    color: _cityNode.hasFocus
                        ? ColorsConstants.defaultBlack
                        : ColorsConstants.defaultBlack.withValues(alpha: 0.3),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // STATE FIELD
              InputField(
                title: "State",
                focusNode: _stateNode,
                onSubmitted: (_) => FocusScope.of(context).unfocus(),
                controller: state,
                hintText: "Uttar Pradesh",
                showBuilder: false,
                prefixIcon: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    _stateNode.hasFocus ? Icons.map : Icons.map_outlined,
                    size: 20,
                    color: _stateNode.hasFocus
                        ? ColorsConstants.defaultBlack
                        : ColorsConstants.defaultBlack.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
