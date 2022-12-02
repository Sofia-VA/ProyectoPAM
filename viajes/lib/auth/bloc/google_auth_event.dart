part of 'google_auth_bloc.dart';

abstract class GoogleAuthEvent extends Equatable {
  const GoogleAuthEvent();

  @override
  List<Object> get props => [];
}

class VerifyGoogleAuthEvent extends GoogleAuthEvent {}

class NewGoogleAuthEvent extends GoogleAuthEvent {}

class SignOutGoogleAuthEvent extends GoogleAuthEvent {}