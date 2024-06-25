
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:midterm_project/src/screens/landing_screen.dart';
import 'package:midterm_project/src/screens/login_screen.dart';
import 'package:midterm_project/src/screens/rest_screen.dart';

class GlobalRouter{
  late GoRouter router;
  late GlobalKey<NavigatorState> _rootNavigatorKey;
  late GlobalKey<NavigatorState> _shellNavigatorKey;

  GlobalRouter(){
    _rootNavigatorKey = GlobalKey<NavigatorState>();
    _shellNavigatorKey = GlobalKey<NavigatorState>();

    router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: LandingScreen.route,
      routes: [
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: LandingScreen.route,
          name: LandingScreen.name,
          builder: (context, _){
            return const LandingScreen();
          },
          routes: [
            GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: LoginScreen.route,
            name: LoginScreen.name,
            builder: (context, _){
            return const LoginScreen();
            }
          ),
          ]
          ),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: RestDemoScreen.route,
            name: RestDemoScreen.name,
            builder: (context, _) {
              return const RestDemoScreen();
            },
            ),
      ],
    );
  }
}