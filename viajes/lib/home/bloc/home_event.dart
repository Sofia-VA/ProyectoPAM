part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class BeginTypingEvent extends HomeEvent {}

class SearchEvent extends HomeEvent {
  final searchString;

  SearchEvent({required this.searchString});
}

class ResetSearchEvent extends HomeEvent {
  final prevState;

  ResetSearchEvent({required this.prevState});
}

class GetPlacesEvent extends HomeEvent {}
