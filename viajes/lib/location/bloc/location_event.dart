part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class RefreshLocationDetailsEvent extends LocationEvent {
  final locationID;

  RefreshLocationDetailsEvent({required this.locationID});
}

class RefreshLocationExperiencesEvent extends LocationEvent {
  final locationID;

  RefreshLocationExperiencesEvent({required this.locationID});
}

class AddToFavoritesEvent extends LocationEvent {
  final locationID;

  AddToFavoritesEvent({required this.locationID});
}

class CheckFavoriteEvent extends LocationEvent {
  final locationID;

  CheckFavoriteEvent({required this.locationID});
}
