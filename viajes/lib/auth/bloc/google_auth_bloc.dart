// ignore_for_file: prefer_final_fields, avoid_print

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart'; 

import '../auth_repo.dart';

part 'google_auth_event.dart';
part 'google_auth_state.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
    UserAuthRepository _authRepo = UserAuthRepository();

  GoogleAuthBloc() : super(GoogleAuthInitial()) {
    on<VerifyGoogleAuthEvent>(_authVerfication);
    on<NewGoogleAuthEvent>(_authUser);
    on<SignOutGoogleAuthEvent>(_signOut);
  }

  FutureOr<void> _authVerfication(event, emit) {
    // inicializar datos de la app
    if (_authRepo.isAlreadyAuthenticated()) {
      emit(GoogleAuthSuccessState());
    } else {
      emit(GoogleAuthErrorState(error: ''));
    }
  }

  FutureOr<void> _signOut(event, emit) async {
    if (FirebaseAuth.instance.currentUser!.isAnonymous) {
      await _authRepo.signOutFirebaseUser();
    } else {
      await _authRepo.signOutGoogleUser();
      await _authRepo.signOutFirebaseUser();
    }
    emit(GoogleAuthSignOutSuccessState());
  }

  FutureOr<void> _authUser(event, emit) async {
    emit(GoogleAuthLoadingState());
    try {
      await _authRepo.signInWithGoogle();
      emit(GoogleAuthSuccessState());
    } catch (e) {
      print("Error al autenticar: $e");
      emit(GoogleAuthErrorState(error: ''));
    }
  }
}
