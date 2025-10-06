// presentation/cubit/location_state.dart
part of 'location_cubit.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final List<LocationEntity> locations;

  LocationLoaded({required this.locations});
}

class LocationError extends LocationState {
  final String message;

  LocationError({required this.message});
}
