import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:midterm_project/src/enum/enum.dart';

class AuthController with ChangeNotifier {
  static void initialize() {
    GetIt.instance.registerSingleton<AuthController>(AuthController());
  }

  static AuthController get instance => GetIt.instance<AuthController>();

  static AuthController get I => GetIt.instance<AuthController>();

  late StreamSubscription<User?> currentAuthedUser;

  AuthState state = AuthState.unauthenticated;

  listen() {
    currentAuthedUser = FirebaseAuth.instance.authStateChanges().listen(handleUserChanges);
  }

  void handleUserChanges(User? user) {
    if (user == null) {
      state = AuthState.unauthenticated;
    } else {
      state = AuthState.authenticated;
    }
    notifyListeners();
  }

  login(String userName, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: userName, password: password);
    return userCredential;
  }

  register(String userName, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userName, password: password);
    return userCredential;
  }

  logout() {
    return FirebaseAuth.instance.signOut();
  }

  loadSession() async {
    listen();
    User? user = FirebaseAuth.instance.currentUser;
    handleUserChanges(user);
  } 
}

