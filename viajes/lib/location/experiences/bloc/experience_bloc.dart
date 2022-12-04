import 'dart:async';
import 'package:intl/intl.dart';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'experience_event.dart';
part 'experience_state.dart';

class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  ExperienceBloc() : super(ExperienceInitial()) {
    on<RefreshExperienceEvent>(_refreshExperience);
    on<LikeExperienceEvent>(_changeLikedStatus);
    on<ResetStateEvent>(_resetState);
  }

  Future<FutureOr<void>> _refreshExperience(
      RefreshExperienceEvent event, Emitter<ExperienceState> emit) async {
    emit(LoadingExperienceState());
    try {
      final experience = await _getExperience(event.experienceID);
      final isLiked = await _getLikedStatus(event.experienceID);
      emit(RefreshExperienceState(experience: experience, isLiked: isLiked));
    } catch (e) {
      print(e);
      emit(GeneralErrorState('Error getting experience info'));
    }
  }

  FutureOr<void> _changeLikedStatus(
      LikeExperienceEvent event, Emitter<ExperienceState> emit) async {
    try {
      final isLiked = await _getLikedStatus(event.experienceID);
      if (isLiked) {
        // TODO: Update experience like count --
        // TODO: Remove from CurrentUser liked experiences
      } else {
        // TODO: Update experience like count ++
        // TODO: Add to CurrentUser liked experiences
      }

      emit(SuccessLikingState(isLiked: !isLiked));
    } catch (e) {
      emit(GeneralErrorState('Error getting experience info'));
    }
  }

  Future<Map<String, dynamic>> _getExperience(experienceID) async {
    Map<String, dynamic> experience = {};
    // Getting experience
    var docRef = await FirebaseFirestore.instance
        .collection("experience")
        .doc(experienceID)
        .get();
    experience = docRef.data()!.cast<String, dynamic>();

    DateTime dt = (experience['date'] as Timestamp).toDate();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(dt);
    experience['formatDate'] = formatted;

    //TODO: Getting User information
    // String userID = experience['authorID'];

    // var placeDocRef = await FirebaseFirestore.instance
    //     .collection("user")
    //     .doc(userID)
    //     .get();
    // Map user = placeDocRef.data()!.cast<String, dynamic>();

    // experience['authorInfo'] = {};
    // experience['authorInfo']['name'] = user['name'];
    // experience['authorInfo']['profilePicture'] = user['profilePicture'];

    // Getting Place information
    Map<String, dynamic> place = {};
    String locationID = experience['locationID'];
    var placeDocRef = await FirebaseFirestore.instance
        .collection("place")
        .doc(locationID)
        .get();
    place = placeDocRef.data()!.cast<String, dynamic>();

    experience['placeInfo'] = {};
    experience['placeInfo']['placeName'] = place['name'];
    experience['placeInfo']['placeCity'] = place['city'];
    experience['placeInfo']['placeCountry'] = place['country'];

    return experience;
  }

  FutureOr<void> _resetState(
      ResetStateEvent event, Emitter<ExperienceState> emit) {
    emit(ExperienceInitial());
  }

  _getLikedStatus(experienceID) async {
    // TODO: Get if current user likes experience
    // String userID = aha

    // var placeDocRef = await FirebaseFirestore.instance
    //     .collection("user")
    //     .doc(userID)
    //     .get();
    // Map user = placeDocRef.data()!.cast<String, dynamic>();
    return false;
  }
}
