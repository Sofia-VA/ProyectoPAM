import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<RefreshLocationDetailsEvent>(_refreshDetails);
    on<RefreshLocationExperiencesEvent>(_refreshExperiences);
    on<CheckFavoriteEvent>(_checkFavorite);
    on<AddToFavoritesEvent>(_addFavorite);
  }

  FutureOr<void> _refreshDetails(
      RefreshLocationDetailsEvent event, Emitter<LocationState> emit) {
    emit(LoadingDetailsState());
    try {
      // TODO: get details
      final location = _getLocationDetails(event.locationID);
      emit(RefreshDetailsState(location: location));
    } catch (e) {
      emit(GeneralErrorState('Error getting location info'));
    }
  }

  FutureOr<void> _refreshExperiences(
      RefreshLocationExperiencesEvent event, Emitter<LocationState> emit) {
    emit(LoadingExperiencesState());
    try {
      // TODO: get experiences
      final experiences = _getLocationExperiences(event.locationID);
      emit(RefreshExperiencesState(experiences: experiences));
    } catch (e) {
      emit(GeneralErrorState('Error getting location info'));
    }
  }

  FutureOr<void> _addFavorite(
      AddToFavoritesEvent event, Emitter<LocationState> emit) {
    try {
      // TODO: Update user DB (add event.locationID to favs)
      // TODO: Update location DB (add event.locationID favorite count)
      emit(SuccessFavoriteAddState());
    } catch (e) {
      emit(GeneralErrorState('Error adding location to favorite'));
    }
  }

  FutureOr<void> _checkFavorite(
      CheckFavoriteEvent event, Emitter<LocationState> emit) {
    // TODO: Check in User fav locations DB
    //True
    emit(SuccessFavoriteAddState());

    //False: do nothing
  }

  Map _getLocationDetails(locationID) {
    // TODO: Get location by ID from DB
    return {};
  }

  List _getLocationExperiences(locationID) {
    // TODO: Get experiences by ID from DB
    return [];
  }
}
