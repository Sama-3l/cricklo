import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'create_tournament_state.dart';

class CreateTournamentCubit extends Cubit<CreateTournamentState> {
  CreateTournamentCubit()
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
