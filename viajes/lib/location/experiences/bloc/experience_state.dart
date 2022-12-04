part of 'experience_bloc.dart';

abstract class ExperienceState extends Equatable {
  const ExperienceState();

  @override
  List<Object> get props => [];
}

class ExperienceInitial extends ExperienceState {}

class LoadingExperienceState extends ExperienceState {}

class SuccessLikingState extends ExperienceState {
  final bool isLiked;

  SuccessLikingState({required this.isLiked});
  @override
  List<Object> get props => [isLiked];
}

class RefreshExperienceState extends ExperienceState {
  final Map experience;
  final bool isLiked;

  RefreshExperienceState({required this.experience, required this.isLiked});
  @override
  List<Object> get props => [experience, isLiked];
}

class GeneralErrorState extends ExperienceState {
  final String msg;

  GeneralErrorState(this.msg);
  @override
  List<Object> get props => [msg];
}
