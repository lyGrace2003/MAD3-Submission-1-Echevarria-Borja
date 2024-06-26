import 'package:flutter/material.dart';
import 'package:midterm_project/src/enum/enum.dart';
import 'package:get_it/get_it.dart';

class AuthController with ChangeNotifier {
  // Static method to initialize the singleton in GetIt
  static void initialize() {
    GetIt.instance.registerSingleton<AuthController>(AuthController());
  }

  // Static getter to access the instance through GetIt
  static AuthController get instance => GetIt.instance<AuthController>();

  static AuthController get I => GetIt.instance<AuthController>();
  AuthState state = AuthState.unauthenticated;
  SimulatedAPI api = SimulatedAPI();

  login(String userName, String password) async {
    bool isLoggedIn = await api.login(userName, password);
    if (isLoggedIn) {
      state = AuthState.authenticated;
      notifyListeners();
    }
  }
}

// logout() {}

// loadSession() async {}

class SimulatedAPI {
  Map<String, String> users = {'usertester': 'passWord!000'};

  Future<bool> login(String userName, String password) async {
    await Future.delayed(const Duration(seconds: 4));
    if (users[userName] == null) throw Exception("User does not exist");
    if (users[userName] != password) throw Exception("Invalid password");
    return users[userName] == password;
  }
}


// import 'package:go_router/go_router.dart';
// import 'package:flutter/material.dart';
// import 'package:midterm_project/src/enum/enum.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hive/hive.dart';
// import 'package:midterm_project/src/screens/landing_screen.dart';
// import 'package:flutter/foundation.dart'; // Import ChangeNotifier

// class AuthController with ChangeNotifier {
//   AuthState _state = AuthState.unauthenticated; // Changed to private field
//   SimulatedAPI api = SimulatedAPI();

//   // Static method to initialize the singleton in GetIt
//   static void initialize() {
//     GetIt.instance.registerSingleton<AuthController>(AuthController());
//   }

//   // Static getter to access the instance through GetIt
//   static AuthController get instance => GetIt.instance<AuthController>();

//   static AuthController get I => GetIt.instance<AuthController>();

//   // Getter to access the state
//   AuthState get state => _state;

//   // Setter to modify the state
//   set state(AuthState newState) {
//     _state = newState;
//     notifyListeners();
//   }

//   Future<void> login(String userName, String password) async {
//     try {
//       bool isLoggedIn = await api.login(userName, password);
//       if (isLoggedIn) {
//         state = AuthState.authenticated;
//         notifyListeners();
//         // Generate a session token (this is just an example, consider using JWT or another secure method)
//         String token = "generatedToken";
//         // Open a box to store the session data
//         var box = await Hive.openBox('session');
//         // Store the session data
//         await box.put('token', token);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   logout() async {
//     var box = await Hive.openBox('session');
//     box.clear(); // Clear all data from the box
//     state = AuthState.unauthenticated;
//     // GoRouter.of(context).go(LandingScreen.route);
//   }


// }

// class SimulatedAPI {
//   Map<String, String> users = {'usertester': 'passWord!000'};

//   Future<bool> login(String userName, String password) async {
//     await Future.delayed(const Duration(seconds: 4));
//     if (users[userName] == null) throw Exception("User does not exist");
//     if (users[userName] != password) throw Exception("Invalid password");
//     return users[userName] == password;
//   }
// }
