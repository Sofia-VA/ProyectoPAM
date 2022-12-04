import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<dynamic> _homePlaces = [];
  List<dynamic> _searchResults = [];
  List<dynamic> get getHomePlaces => _homePlaces;
  List<dynamic> get getSearchResults => _searchResults;

  HomeBloc() : super(HomeInitial()) {
    on<BeginTypingEvent>(_loadSuggestions);
    on<SearchEvent>(_search);
    on<ResetSearchEvent>(_resetSearch);
    on<GetPlacesEvent>(_getPlaces);
  }

  Future<void> _createPlaceCollection(String uid) async {
    var userDoc =
        await FirebaseFirestore.instance.collection("place").doc(uid).get();
    // Si no exite el doc, lo crea con valor default lista vacia
    if (!userDoc.exists) {
      await FirebaseFirestore.instance.collection("place").doc(uid).set(
        {
          "name": '',
          "city": '',
          "country": '',
          "picture": '',
          "schedule": '',
          'favorites': 0,
          "averageStars": 0,
          "averageWeather": '',
          "experiencesCount": 0,
          'description': '',
          'experiences': [],
          "activities": [],
          "tags": [],
          "registeredCosts": [],
          "registeredStars": [],
        },
      );
    } else {
      // Si ya existe el doc return
      return;
    }
  }

  FutureOr<void> _loadSuggestions(
      BeginTypingEvent event, Emitter<HomeState> emit) {
    emit(isTypingState());
  }

  FutureOr<void> _getPlaces(
      GetPlacesEvent event, Emitter<HomeState> emit) async {
    emit(LoadingState());
    try {
      _homePlaces = await _getPlacesQuery('');
      emit(LoadedPlacesState(places: _homePlaces));
      // List of places
      //emit(LoadedPlacesState(places: places));
    } catch (e) {
      emit(Failure(errorMsg: '${e}'));
    }
  }
}

FutureOr<void> _search(SearchEvent event, Emitter<HomeState> emit) async {
  emit(SearchingState());
  print(event.searchString);
  if (!event.searchString.isNotEmpty) return null;
  try {
    List _searchResults = await _getPlacesQuery(event.searchString);
    emit(ResultsState(places: _searchResults));
  } catch (e) {
    emit(Failure(errorMsg: '${e}'));
  }
}

_getPlacesQuery(String filter) async {
  // Documents of Places
  var queryPlaces = await FirebaseFirestore.instance.collection("place");
  // Get places
  var docsRef;
  if (filter != '') {
    docsRef = await queryPlaces //.where("name", isEqualTo: filter).get();
        .where('searchKey', isGreaterThanOrEqualTo: filter)
        .where('searchKey', isLessThan: filter + 'z')
        .get();
  } else {
    docsRef = await queryPlaces.get();
  }

  final places = docsRef.docs.map((doc) {
    var parsedDoc = doc.data().cast<String, dynamic>();
    parsedDoc['id'] = doc.id;
    return parsedDoc;
  }).toList();
  return places;
}

FutureOr<void> _resetSearch(ResetSearchEvent event, Emitter<HomeState> emit) {
  if (event.prevState is HomeInitial) {
    emit(HomeInitial());
  } else if (event.prevState is ResultsState) {
    emit(ResultsState(places: []));
  } else {
    emit(HomeInitial());
  }
}
