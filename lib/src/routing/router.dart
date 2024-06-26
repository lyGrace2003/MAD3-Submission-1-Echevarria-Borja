// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:go_router/go_router.dart';
// import 'package:midterm_project/src/controllers/auth_controller.dart';
// import 'package:midterm_project/src/enum/enum.dart';
// import 'package:midterm_project/src/screens/landing_screen.dart';
// import 'package:midterm_project/src/screens/login_screen.dart';
// import 'package:midterm_project/src/screens/rest_screen.dart';

// class GlobalRouter {
//   static void initialize() {
//     GetIt.instance.registerSingleton<GlobalRouter>(GlobalRouter());
//   }

//   static GlobalRouter get instance => GetIt.instance<GlobalRouter>();

//   late GoRouter router;
//   late GlobalKey<NavigatorState> _rootNavigatorKey;

//   GlobalRouter() {
//     _rootNavigatorKey = GlobalKey<NavigatorState>();

//     router = GoRouter(
//       navigatorKey: _rootNavigatorKey,
//       initialLocation: LandingScreen.route,
//       redirect: handleRedirect,
//       refreshListenable: AuthController.I,
//       routes: [
//         GoRoute(
//           path: LandingScreen.route,
//           builder: (context, _) {
//             return const LandingScreen();
//           },
//         ),
//         GoRoute(
//           path: LoginScreen.route,
//           builder: (context, _) {
//             return const LoginScreen();
//           },
//         ),
//         GoRoute(
//           path: RestDemoScreen.route,
//           builder: (context, _) {
//             return const RestDemoScreen();
//           },
//         ),
//       ],
//     );
//   }

//   FutureOr<String?> handleRedirect(
//       BuildContext context, GoRouterState state) async {
//     if (AuthController.I.state != AuthState.authenticated &&
//         state.matchedLocation == LandingScreen.route) {
//       return LandingScreen.route;
//     }

//     if (AuthController.I.state == AuthState.authenticated &&
//         state.matchedLocation == LoginScreen.route) {
//       return RestDemoScreen.route;
//     }

//     if (AuthController.I.state != AuthState.authenticated &&
//         state.matchedLocation != LoginScreen.route) {
//       return LoginScreen.route;
//     }

//     return null;
//   }

//   // Example of triggering logout from a widget's build method
//   void logout(BuildContext context) {
//     router.go(LandingScreen.route);
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:midterm_project/src/screens/landing_screen.dart';
// import 'package:midterm_project/src/screens/login_screen.dart';
// import 'package:midterm_project/src/screens/rest_screen.dart';
// import 'package:midterm_project/src/model/user_model.dart'; // Import UserModel here

// class GlobalRouter {
//   static final GlobalRouter _instance = GlobalRouter();

//   factory GlobalRouter() => _instance;

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
//             parentNavigatorKey: _rootNavigatorKey,
//             path: LandingScreen.route,
//             name: LandingScreen.name,
//             builder: (context, _) {
//               return const LandingScreen();
//             },
//             routes: [
//               GoRoute(
//                   parentNavigatorKey: _rootNavigatorKey,
//                   path: LoginScreen.route,
//                   name: LoginScreen.name,
//                   builder: (context, _) {
//                     return const LoginScreen();
//                   }),
//             ]),
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

//   // Add the authenticate method here
//   bool authenticate(String username, String password) {
//     return predefinedAccount.username == username &&
//         predefinedAccount.password == password;
//   }

//   void logout() {
//     GoRouter.of(_rootNavigatorKey.currentContext!).go(LandingScreen.route);
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart';
// // import 'package:midterm_project/src/screens/landing_screen.dart';
// // import 'package:midterm_project/src/screens/login_screen.dart';
// // import 'package:midterm_project/src/screens/rest_screen.dart';

// // class GlobalRouter {
// //   late GoRouter router;
// //   late GlobalKey<NavigatorState> _rootNavigatorKey;
// //   late GlobalKey<NavigatorState> _shellNavigatorKey;

// //   GlobalRouter() {
// //     _rootNavigatorKey = GlobalKey<NavigatorState>();
// //     _shellNavigatorKey = GlobalKey<NavigatorState>();

// //     router = GoRouter(
// //       navigatorKey: _rootNavigatorKey,
// //       initialLocation: LandingScreen.route,
// //       routes: [
// //         GoRoute(
// //           parentNavigatorKey: _rootNavigatorKey,
// //           path: LandingScreen.route,
// //           name: LandingScreen.name,
// //           builder: (context, _) {
// //             return const LandingScreen();
// //           },
// //           routes: [
// //             GoRoute(
// //                 parentNavigatorKey: _rootNavigatorKey,
// //                 path: LoginScreen.route,
// //                 name: LoginScreen.name,
// //                 builder: (context, _) {
// //                   return const LoginScreen();
// //                 }),
// //           ],
// //         ),
// //         GoRoute(
// //           parentNavigatorKey: _rootNavigatorKey,
// //           path: RestDemoScreen.route,
// //           name: RestDemoScreen.name,
// //           builder: (context, _) {
// //             return const RestDemoScreen();
// //           },
// //         ),
// //       ],
// //     );
// //   }
// // }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:midterm_project/src/controllers/auth_controller.dart';
import 'package:midterm_project/src/enum/enum.dart';
import 'package:midterm_project/src/screens/landing_screen.dart';
import 'package:midterm_project/src/screens/login_screen.dart';
import 'package:midterm_project/src/screens/rest_screen.dart';
import 'package:midterm_project/src/model/user_model.dart';

class GlobalRouter {
  static void initialize() {
    GetIt.instance.registerSingleton<GlobalRouter>(GlobalRouter());
  }

  // Static getter to access the instance through GetIt
  static GlobalRouter get instance => GetIt.instance<GlobalRouter>();

  static GlobalRouter get I => GetIt.instance<GlobalRouter>();

  // final Box<Post> _postBox = Hive.box<Post>('posts');
  static final GlobalRouter _instance = GlobalRouter();

  //factory GlobalRouter() => _instance;

  late GoRouter router;
  late GlobalKey<NavigatorState> _rootNavigatorKey;
  late GlobalKey<NavigatorState> _shellNavigatorKey;

  FutureOr<String?> handleRedirect(
      BuildContext context, GoRouterState state) async {
    // If the user is not authenticated and is on the landing page, redirect to login
    if (AuthController.I.state != AuthState.authenticated &&
        state.matchedLocation == LandingScreen.route) {
      return LandingScreen.route;
    }

    // If the user is authenticated and is on the login page, redirect to rest demo
    if (AuthController.I.state == AuthState.authenticated) {
      if (state.matchedLocation == LoginScreen.route) {
        return RestDemoScreen.route;
      }
      return null; // No redirect needed
    }

    // If the user is not authenticated and is trying to access rest demo, redirect to login
    if (AuthController.I.state != AuthState.authenticated) {
      if (state.matchedLocation != LoginScreen.route) {
        return LoginScreen.route;
      }
    }
    if (AuthController.I.state == AuthState.authenticated &&
        state.matchedLocation == RestDemoScreen.route) {
      return LandingScreen.route;
    }

    return null; // No redirect needed
  }

  GlobalRouter() {
    _rootNavigatorKey = GlobalKey<NavigatorState>();
    _shellNavigatorKey = GlobalKey<NavigatorState>();

    router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: LandingScreen.route,
      redirect: handleRedirect,
      refreshListenable: AuthController.I,
      routes: [
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: LandingScreen.route,
          name: LandingScreen.name,
          builder: (context, _) {
            return const LandingScreen();
          },
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: LoginScreen.route,
          name: LoginScreen.name,
          builder: (context, _) {
            return const LoginScreen();
          },
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

  // Add the authenticate method here
  Future<bool> authenticate(String username, String password) async {
    if (predefinedAccount.username == username &&
        predefinedAccount.password == password) {
      return true;
    }
    return false;
  }

  void logout() {
    GoRouter.of(_rootNavigatorKey.currentContext!).go(LandingScreen.route);
  }
}
