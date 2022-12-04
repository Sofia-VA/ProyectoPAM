part of 'experience_bloc.dart';

@immutable
abstract class ExperienceEvent extends Equatable {
  const ExperienceEvent();

  @override
  List<Object> get props => [];
}

class ResetStateEvent extends ExperienceEvent {}

class RefreshExperienceEvent extends ExperienceEvent {
  final experienceID;

  RefreshExperienceEvent({required this.experienceID});
}

class LikeExperienceEvent extends ExperienceEvent {
  final experienceID;

  LikeExperienceEvent({required this.experienceID});
}
