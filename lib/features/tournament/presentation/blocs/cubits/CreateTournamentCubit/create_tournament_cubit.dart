import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/tournament/data/usecases/create_tournament_usecase.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'create_tournament_state.dart';

class CreateTournamentCubit extends Cubit<CreateTournamentState> {
  final CreateTournamentUsecase _createTournamentUsecase;

  CreateTournamentCubit(this._createTournamentUsecase)
    : super(
        CreateTournamentUpdate(
          loading: false,
          bannerLoading: false,
          banner: null,
        ),
      );

  Future<void> pickBanner() async {
    final ImagePicker picker = ImagePicker();
    emit(state.copyWith(bannerLoading: true));
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
        emit(
          state.copyWith(banner: File(croppedFile.path), bannerLoading: true),
        );
      } else {
        emit(state.copyWith(bannerLoading: false));
      }
    } else {
      emit(state.copyWith(bannerLoading: false));
    }
  }

  createTournament(
    BuildContext context,
    TournamentEntity tournamentEntity,
    Function(TournamentEntity tournament) onCreate,
  ) async {
    emit(state.copyWith(loading: true));
    final response = await _createTournamentUsecase(tournamentEntity);
    response.fold(
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            // behavior: SnackBarBehavior.floating,
            backgroundColor: ColorsConstants.defaultBlack,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            content: Text(
              "Something went wrong",
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 16,
                letterSpacing: -0.8,
                color: ColorsConstants.defaultWhite,
              ),
            ),
          ),
        );
        emit(state.copyWith(loading: false));
      },
      (response) {
        if (response.success) {
          emit(state.copyWith(loading: false));
          final tournament = tournamentEntity.copyWith(
            id: response.tournamentId!,
          );
          print(tournament.id);
          onCreate(tournament);
          GoRouter.of(context).go(Routes.mainAppScreen);
        }
      },
    );
    emit(state.copyWith(loading: false));
  }
}
