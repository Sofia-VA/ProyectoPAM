part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class beginTypingEvent extends HomeEvent {}

class searchEvent extends HomeEvent {
  final searchString;

  searchEvent({required this.searchString});
}

class resetSearchEvent extends HomeEvent {
  final prevState;

  resetSearchEvent({required this.prevState});
}
