import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:midterm_project/src/screens/landing_screen.dart';
import 'package:midterm_project/src/screens/login_screen.dart';
import 'package:midterm_project/src/screens/rest_screen.dart';
import 'package:midterm_project/src/model/user_model.dart'; // Import UserModel here

class GlobalRouter {
  static final GlobalRouter _instance = GlobalRouter._internal();

  factory GlobalRouter() => _instance;

  late GoRouter router;
  late GlobalKey<NavigatorState> _rootNavigatorKey;
  late GlobalKey<NavigatorState> _shellNavigatorKey;

  GlobalRouter._internal() {
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
            builder: (context, _) {
              return const LandingScreen();
            },
            routes: [
              GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: LoginScreen.route,
                  name: LoginScreen.name,
                  builder: (context, _) {
                    return const LoginScreen();
                  }),
            ]),
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

  // Add the authenticate method here
  bool authenticate(String username, String password) {
    return predefinedAccount.username == username &&
        predefinedAccount.password == password;
  }

  void logout() {
    GoRouter.of(_rootNavigatorKey.currentContext!).go(LandingScreen.route);
  }
}





// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:midterm_project/src/screens/landing_screen.dart';
// import 'package:midterm_project/src/screens/login_screen.dart';
// import 'package:midterm_project/src/screens/rest_screen.dart';

// class GlobalRouter {
//   late GoRouter router;
//   late GlobalKey<NavigatorState> _rootNavigatorKey;
//   late GlobalKey<NavigatorState> _shellNavigatorKey;

//   GlobalRouter() {
//     _rootNavigatorKey = GlobalKey<NavigatorState>();
//     _shellNavigatorKey = GlobalKey<NavigatorState>();

//     router = GoRouter(
//       navigatorKey: _rootNavigatorKey,
//       initialLocation: LandingScreen.route,
//       routes: [
//         GoRoute(
//           parentNavigatorKey: _rootNavigatorKey,
//           path: LandingScreen.route,
//           name: LandingScreen.name,
//           builder: (context, _) {
//             return const LandingScreen();
//           },
//           routes: [
//             GoRoute(
//                 parentNavigatorKey: _rootNavigatorKey,
//                 path: LoginScreen.route,
//                 name: LoginScreen.name,
//                 builder: (context, _) {
//                   return const LoginScreen();
//                 }),
//           ],
//         ),
//         GoRoute(
//           parentNavigatorKey: _rootNavigatorKey,
//           path: RestDemoScreen.route,
//           name: RestDemoScreen.name,
//           builder: (context, _) {
//             return const RestDemoScreen();
//           },
//         ),
//       ],
//     );
//   }
// }
