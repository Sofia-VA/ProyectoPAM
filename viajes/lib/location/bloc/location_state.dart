part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LoadingDetailsState extends LocationState {}

class LoadingExperiencesState extends LocationState {}

class SuccessFavoriteAddState extends LocationState {}

class RefreshDetailsState extends LocationState {
  final Map location;

  RefreshDetailsState({required this.location});
  @override
  List<Object> get props => [location];
}

class RefreshExperiencesState extends LocationState {
  final List experiences;

  RefreshExperiencesState({required this.experiences});
  @override
  List<Object> get props => [experiences];
}

class GeneralErrorState extends LocationState {
  final String msg;

  GeneralErrorState(this.msg);
  @override
  List<Object> get props => [msg];
}
