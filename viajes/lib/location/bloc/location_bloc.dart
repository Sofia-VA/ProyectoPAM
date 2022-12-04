import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<RefreshLocationDetailsEvent>(_refreshDetails);
    on<RefreshLocationExperiencesEvent>(_refreshExperiences);
    on<CheckFavoriteEvent>(_checkFavorite);
    on<AddToFavoritesEvent>(_addFavorite);
  }

  Future<FutureOr<void>> _refreshDetails(
      RefreshLocationDetailsEvent event, Emitter<LocationState> emit) async {
    emit(LoadingDetailsState());
    try {
      final location = await _getLocationDetails(event.locationID);
      emit(RefreshDetailsState(location: location));
    } catch (e) {
      emit(GeneralErrorState('Error getting location info'));
    }
  }

  Future<FutureOr<void>> _refreshExperiences(
      RefreshLocationExperiencesEvent event,
      Emitter<LocationState> emit) async {
    emit(LoadingExperiencesState());
    try {
      // TODO: get experiences
      final experiences = await _getLocationExperiences(event.locationID);
      emit(RefreshExperiencesState(experiences: experiences));
    } catch (e) {
      emit(GeneralErrorState('Error getting location experiences'));
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

  Future<Map<String, dynamic>> _getLocationDetails(locationID) async {
    // Gets location info by ID from DB
    Map<String, dynamic> place = {};

    var docRef = await FirebaseFirestore.instance
        .collection("place")
        .doc(locationID)
        .get();
    place = docRef.data()!.cast<String, dynamic>();

    return place;
  }

  Future<List> _getLocationExperiences(locationID) async {
    // TODO: Get experiences by ID from DB
    List<dynamic> experiences = [];

    var docsRef = await _getLocationDetails(locationID);
    List listIds = docsRef["experiences"];

    // Query to get experience docs
    var docRefs =
        await FirebaseFirestore.instance.collection("experience").get();

    // Filter experiences with ids
    experiences =
        docRefs.docs.where((doc) => listIds.contains(doc.id)).map((doc) {
      var parsedDoc = doc.data().cast<String, dynamic>();
      parsedDoc['id'] = doc.id;
      return parsedDoc;
    }).toList();

    return experiences;
  }
}
