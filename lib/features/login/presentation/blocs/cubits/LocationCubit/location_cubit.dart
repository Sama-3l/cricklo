// presentation/cubit/location_cubit.dart
import 'package:cricklo/features/login/data/usecases/search_location_usecase.dart';
import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final SearchLocationUseCase useCase;

  LocationCubit({required this.useCase}) : super(LocationInitial());

  Future<void> searchLocations(String query) async {
    if (query.isEmpty) {
      emit(LocationInitial());
      return;
    }

    emit(LocationLoading());
    try {
      final results = await useCase(query);
      emit(LocationLoaded(locations: results));
    } catch (e) {
      emit(LocationError(message: e.toString()));
    }
  }
}
