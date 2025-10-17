import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/teams/data/usecases/create_team_usecase.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'create_team_state.dart';

class CreateTeamCubit extends Cubit<CreateTeamState> {
  final CreateTeamUsecase _createTeamUsecase;
  CreateTeamCubit(this._createTeamUsecase) : super(CreateTeamUpdate());

  createTeam(TeamEntity team, BuildContext context) async {
    emit(state.copyWith(loading: true));
    final response = await _createTeamUsecase(team);
    response.fold((_) {}, (response) {
      if (response.success) {
        emit(state.copyWith(loading: false));
        GoRouter.of(
          context,
        ).pushNamed(Routes.addPlayersToTeam, extra: response.team);
      }
    });
    emit(state.copyWith(loading: false));
  }

  Future<void> pickLogo() async {
    final ImagePicker picker = ImagePicker();
    emit(state.copyWith(logoLoading: true));
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
        emit(state.copyWith(logo: File(pickedFile.path), logoLoading: false));
      } else {
        emit(state.copyWith(logoLoading: false));
      }
    } else {
      emit(state.copyWith(logoLoading: false));
    }
  }

  Future<void> pickBanner() async {
    final ImagePicker picker = ImagePicker();
    emit(state.copyWith(bannerLoading: true));
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

      //       aspectRatioPresets: [
      //         CropAspectRatioPreset.square,
      //         CropAspectRatioPreset.ratio16x9,
      //         CropAspectRatioPreset.original,
      //       ],
      //     ),

      //     IOSUiSettings(
      //       title: 'Edit Image',
      //       aspectRatioPresets: [
      //         CropAspectRatioPreset.square,
      //         CropAspectRatioPreset.ratio16x9,
      //         CropAspectRatioPreset.original,
      //       ],
      //     ),
      //   ],
      // );

      if (pickedFile != null) {
        emit(
          state.copyWith(banner: File(pickedFile.path), bannerLoading: true),
        );
      } else {
        emit(state.copyWith(bannerLoading: false));
      }
    } else {
      emit(state.copyWith(bannerLoading: false));
    }
  }
}
