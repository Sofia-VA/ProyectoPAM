// ignore_for_file: prefer_const_constructors_in_immutables, unnecessary_this

part of 'experiences_bloc.dart';

abstract class ExperiencesEvent extends Equatable {
  const ExperiencesEvent();

  @override
  List<Object> get props => [];
}

class GetAllExperiencesEvent extends ExperiencesEvent {}

class AddExperienceEvent extends ExperiencesEvent {
  final Experience experienceToAdd;

  AddExperienceEvent({required this.experienceToAdd});

  @override
  List<Object> get props => [this.experienceToAdd];
}

class GetAllChips extends ExperiencesEvent {}
