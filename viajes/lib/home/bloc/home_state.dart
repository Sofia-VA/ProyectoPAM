part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class LoadingState extends HomeState {}

class LoadedPlacesState extends HomeState {
  final List<dynamic> places;

  LoadedPlacesState({required this.places});

  @override
  List<Object> get props => [places];
}

class isTypingState extends HomeState {}

class ResultsState extends HomeState {
  final List<dynamic> places;

  ResultsState({required this.places});

  @override
  List<Object> get props => [places];
}

class SearchingState extends HomeState {}

class Failure extends HomeState {
  final String errorMsg;

  Failure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
