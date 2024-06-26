// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:midterm_project/src/routing/router.dart';
// import 'package:midterm_project/src/screens/rest_screen.dart';

// class LoginScreen extends StatefulWidget {
//   static const String route = 'auth';
//   static const String path = "/auth";

//   static const String name = 'LoginScreen';
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// // class _LoginScreenState extends State<LoginScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return const Scaffold(
// //       body: Text("Login Page"),
// //     );
// //   }
// // }

// // Update your login_screen.dart file

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final GlobalKey<FormState> _formKey =
//       GlobalKey<FormState>(); // Declare _formKey here

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login')),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           // Wrap your Column with a Form widget
//           key: _formKey, // Assign the _formKey to the Form widget
//           child: Column(
//             children: [
//               TextFormField(
//                 // Change TextField to TextFormField for validation support
//                 controller: _usernameController,
//                 decoration: InputDecoration(labelText: 'Username'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your username';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 // Change TextField to TextFormField for validation support
//                 controller: _passwordController,
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   return null;
//                 },
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     // Use _formKey to validate the form
//                     bool isAuthenticated = await GlobalRouter().authenticate(
//                         _usernameController.text, _passwordController.text);
//                     if (isAuthenticated) {
//                       GoRouter.of(context).go(RestDemoScreen.route);
//                       // Navigate to the next screen or update UI accordingly
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                           content: Text('Invalid username or password')));
//                       // Show an error message
//                     }
//                   }
//                 },
//                 child: Text('Login'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//-------------------------------------

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:midterm_project/src/routing/router.dart';
import 'package:midterm_project/src/screens/rest_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String route = 'auth';
  static const String path = "/auth";

  static const String name = 'LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Login', style: TextStyle(color: Colors.black),),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Container(
                  height: 60,
                  width: 380,
                  child: TextFormField(
                    controller: _usernameController,
                    decoration:  InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFF00BF62)),
                            borderRadius: BorderRadius.circular(10),),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFF00BF62)),
                            borderRadius: BorderRadius.circular(10),),
                        labelText: "Username",
                        labelStyle: const TextStyle(color: Colors.black),
                        errorStyle: const TextStyle(color: Colors.red), 
                        errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color:Colors.red),
                            borderRadius: BorderRadius.circular(10),), 
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),)), 
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username'; 
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Container(
                  height: 60,
                  width: 380,
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFF00BF62)),
                            borderRadius: BorderRadius.circular(10),),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFF00BF62)),
                            borderRadius: BorderRadius.circular(10),),
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.black),
                        errorStyle: const TextStyle(color: Colors.red), 
                        errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color:Colors.red),
                            borderRadius: BorderRadius.circular(10),), 
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password'; // This message will now appear in the field itself
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool isAuthenticated = await GlobalRouter()
                              .authenticate(_usernameController.text,
                                  _passwordController.text);
                          if (isAuthenticated) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              backgroundColor: Color(0xFF00BF62),
                              content: Text(
                                'Logged in Successfully!',
                                style: TextStyle(color: Colors.white),
                              ),
                            ));
                            GoRouter.of(context).go(RestDemoScreen.route);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              backgroundColor: Color(0xFF00BF62),
                              content: Text(
                                'Invalid username or password',
                                style: TextStyle(color: Colors.white),
                              ),
                            ));
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(const Color(0xFF00BF62)),
                      ),
                      child: const Text('Login',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
