// ignore_for_file: avoid_print, non_constant_identifier_names, unnecessary_string_interpolations

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:viajes/auth/auth_repo.dart';

import '../experience.dart';

part 'experiences_event.dart';
part 'experiences_state.dart';

class ExperiencesBloc extends Bloc<ExperiencesEvent, ExperiencesState> {
  ExperiencesBloc() : super(ExperiencesInitial()) {
    on<GetAllExperiencesEvent>(getAllExperiences);
    on<AddExperienceEvent>(AddExperience);
    on<GetAllChips>(getAllChips);
  }

  FutureOr<void> getAllExperiences(event, emit) async {
    emit(ExperiencesLoadingState());
    try {
      // Get experiences from user - Gets array of IDS
      DocumentSnapshot<Map<String, dynamic>> docsRef =
          await getDocsFromCurrentUser();
      List<dynamic> userSongs = docsRef.data()?["experiencesList"] ?? [];

      // Get all experiences
      QuerySnapshot<Map<String, dynamic>> allSongs =
          await FirebaseFirestore.instance.collection("experience").get();

      // JOIN user.experiences with allExperiences - Array of docs (Experiences)
      var listOfExperiencesJoined =
          allSongs.docs.where((doc) => userSongs.contains(doc.id)).toList();
      // Convert list of docs, to list of Map<String, dynamic>
      var favExperienceList = listOfExperiencesJoined
          .map((doc) => doc.data().cast<String, dynamic>())
          .toList();

      if (favExperienceList.isEmpty) {
        emit(ExperiencesEmptyState());
      } else {
        emit(ExperiencesSuccessState(experience: favExperienceList));
      }
    } catch (e) {
      print("Error while getting disabled experiences: $e");
    }
  }

  FutureOr<void> AddExperience(event, emit) async {
    emit(ExperiencesLoadingState());
    try {
      // Upload the new experience to all experiences
      String newId = await uploadNewExperience(event.experienceToAdd);

      // Get experience from user + newExperience - Gets array of IDS
      DocumentSnapshot<Map<String, dynamic>> docsRef =
          await getDocsFromCurrentUser();
      List<dynamic> userExperiences = docsRef.data()?["experience"] ?? [];
      userExperiences.add(newId);

      // Get all experiences
      QuerySnapshot<Map<String, dynamic>> allExperiences =
          await FirebaseFirestore.instance.collection("experience").get();

      // JOIN user.experiences with allExperiences - Array of docs (Experiences)
      var listOfExperiencesJoined = allExperiences.docs
          .where((doc) => userExperiences.contains(doc.id))
          .toList();

      // Convert list of docs, to list of Map<String, dynamic>
      var experiencesList = listOfExperiencesJoined
          .map((doc) => doc.data().cast<String, dynamic>())
          .toList();

      if (experiencesList.isEmpty) {
        emit(ExperiencesEmptyState());
      } else {
        UserAuthRepository repo = UserAuthRepository();
        // We switch the user's experienceList with newUserExperienceList (The updated one)
        repo.createUserCollectionFromCopy(
            FirebaseAuth.instance.currentUser!.uid, userExperiences);
        print("Created a new experience");
        emit(ExperiencesSuccessState(experience: experiencesList));
      }
    } catch (e) {
      print("Error while getting items: $e");
    }
  }

  // Just reusable method to get current user's docs
  Future<DocumentSnapshot<Map<String, dynamic>>>
      getDocsFromCurrentUser() async {
    var queryUser = FirebaseFirestore.instance
        .collection("users")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");
    // get data from document
    DocumentSnapshot<Map<String, dynamic>> docsRef = await queryUser.get();
    return docsRef;
  }

  // Create a new document and add it to experiences collection
  Future<String> uploadNewExperience(Experience newExperience) async {
    try {
      DocumentReference addedExperience = await FirebaseFirestore.instance
          .collection('experience')
          .add(newExperience.getExperienceAsMap());
      return addedExperience.id;
    } catch (e) {
      print("Error while adding a new experience to all songs: $e");
      return "";
    }
  }

  FutureOr<void> getAllChips(event, emit) async {
    emit(ExperiencesLoadingState());

    try {
      // Get chips from db
      var queryChips = FirebaseFirestore.instance
          .collection("tags")
          .doc('jPTuWwmVa6QDOlviJSuN');
      DocumentSnapshot<Map<String, dynamic>> docsRef = await queryChips.get();
      List<dynamic> allChips = docsRef.data()?["chips"] ?? [];
      emit(ChipsSuccesState(chips: allChips));
    } catch (e) {
      print("Error while getting chips: $e");
    }
  }
}
