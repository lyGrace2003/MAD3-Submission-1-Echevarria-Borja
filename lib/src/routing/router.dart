import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:midterm_project/src/controllers/auth_controller.dart';
import 'package:midterm_project/src/enum/enum.dart';
import 'package:midterm_project/src/model/post_model.dart';
import 'package:midterm_project/src/screens/landing_screen.dart';
import 'package:midterm_project/src/screens/login_screen.dart';
import 'package:midterm_project/src/screens/rest_screen.dart'; // Adjusted import

class GlobalRouter {
  final Box<Post> _postBox = Hive.box<Post>('posts');
  static void initialize() {
    GetIt.instance.registerSingleton<GlobalRouter>(GlobalRouter());
  }

  static GlobalRouter get instance => GetIt.instance<GlobalRouter>();

  late GoRouter router;
  late GlobalKey<NavigatorState> _rootNavigatorKey;

  GlobalRouter() {
    _rootNavigatorKey = GlobalKey<NavigatorState>();

    router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: LandingScreen.route,
      redirect: handleRedirect,
      refreshListenable: AuthController.instance,
      routes: [
        GoRoute(
          path: LandingScreen.route,
          builder: (context, state) => const LandingScreen(),
        ),
        GoRoute(
          path: LoginScreen.route,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: RestDemoScreen.route,
          builder: (context, state) => const RestDemoScreen(),
        ),
      ],
    );
  }

  FutureOr<String?> handleRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    if (AuthController.instance.state != AuthState.authenticated &&
        state.matchedLocation == LandingScreen.route) {
      return LandingScreen.route;
    }

    if (AuthController.instance.state == AuthState.authenticated) {
      if (state.matchedLocation == LoginScreen.route) {
        return RestDemoScreen.route;
      }
      return null;
    }

    if (AuthController.instance.state != AuthState.authenticated &&
        state.matchedLocation != LoginScreen.route) {
      return LoginScreen.route;
    }

    return null;
  }

  void clearHiveData() {
    _postBox.clear();
  }

  void logout(BuildContext context) {
    clearHiveData();
    GoRouter.of(context).go(LandingScreen.route);
  }
}
