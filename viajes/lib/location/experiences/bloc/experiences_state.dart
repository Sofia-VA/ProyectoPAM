// ignore_for_file: prefer_const_constructors_in_immutables, unnecessary_this

part of 'experiences_bloc.dart';

abstract class ExperiencesState extends Equatable {
  const ExperiencesState();

  @override
  List<Object> get props => [];
}

class ExperiencesInitial extends ExperiencesState {}

class ExperiencesSuccessState extends ExperiencesState {
  final List<dynamic> experience;

  ExperiencesSuccessState({required this.experience});

  @override
  List<Object> get props => [this.experience];
}

class ExperiencesErrorState extends ExperiencesState {}

class ExperiencesEmptyState extends ExperiencesState {}

class ExperiencesLoadingState extends ExperiencesState {}

class ChipsSuccesState extends ExperiencesState {
  final List<dynamic> chips;
  ChipsSuccesState({required this.chips});

  @override
  List<Object> get props => [this.chips];
}
