import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<beginTypingEvent>(_loadSuggestions);
    on<searchEvent>(_search);
    on<resetSearchEvent>(_resetSearch);
  }

  FutureOr<void> _loadSuggestions(
      beginTypingEvent event, Emitter<HomeState> emit) {
    emit(isTypingState());
  }

  FutureOr<void> _search(searchEvent event, Emitter<HomeState> emit) {
    emit(SearchingState());
    print(event.searchString);
    if (!event.searchString.isNotEmpty) return null;

    emit(ResultsState());
  }

  FutureOr<void> _resetSearch(resetSearchEvent event, Emitter<HomeState> emit) {
    if (event.prevState is HomeInitial) {
      emit(HomeInitial());
    } else if (event.prevState is ResultsState) {
      emit(ResultsState());
    } else {
      emit(HomeInitial());
    }
  }
}
