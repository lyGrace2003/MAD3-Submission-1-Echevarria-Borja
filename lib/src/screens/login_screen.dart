import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:midterm_project/src/controllers/auth_controller.dart';
import 'package:midterm_project/src/dialogs/waiting_dialog.dart';

class LoginScreen extends StatefulWidget {
  // static const String route = 'auth';
  static const String route = "/auth";

  static const String name = "Login Screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController username, password;
  late FocusNode usernameFn, passwordFn;

  bool obfuscate = true;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    username = TextEditingController();
    password = TextEditingController();
    usernameFn = FocusNode();
    passwordFn = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
    usernameFn.dispose();
    passwordFn.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Login', style: TextStyle(color: Colors.white),),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.only(bottom: 16),
          height: 52,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all<Color>(const Color(0xFF00BF62)),
            ),
            onPressed: () {
              onSubmit();
            },
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: TextFormField(
                    decoration: decoration.copyWith(
                      labelText: "Username",
                      hintText: 'Enter your username',
                      prefixIcon:
                          const Icon(Icons.person, color: Color(0xFF00BF62)),
                    ),
                    focusNode: usernameFn,
                    controller: username,
                    onEditingComplete: () {
                      passwordFn.requestFocus();
                    },
                    validator: MultiValidator([
                      RequiredValidator(
                          errorText: 'Please fill out the username'),
                      MaxLengthValidator(32,
                          errorText: "Username cannot exceed 32 characters"),
                      PatternValidator(r'^[a-zA-Z0-9 ]+$',
                          errorText:
                              'Username cannot contain special characters'),
                    ]).call,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Flexible(
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obfuscate,
                    decoration: decoration.copyWith(
                        // errorStyle: const TextStyle(color: Colors.red),
                        labelText: "Password",
                        hintText: 'Enter your password',
                        prefixIcon:
                            const Icon(Icons.lock, color: Color(0xFF00BF62)),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obfuscate = !obfuscate;
                              });
                            },
                            icon: Icon(obfuscate
                                ? Icons.remove_red_eye_rounded
                                : CupertinoIcons.eye_slash))),
                    focusNode: passwordFn,
                    controller: password,
                    onEditingComplete: () {
                      passwordFn.unfocus();
                    },
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Password is required"),
                      MinLengthValidator(12,
                          errorText:
                              "Password must be at least 12 characters long"),
                      MaxLengthValidator(128,
                          errorText: "Password cannot exceed 72 characters"),
                      PatternValidator(
                          r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+?\-=[\]{};':,.<>]).*$",
                          errorText:
                              'Password must contain at least one symbol, one uppercase letter, one lowercase letter, and one number.')
                    ]).call,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      WaitingDialog.show(context,
          future: AuthController.I
              .login(username.text.trim(), password.text.trim()));
      GoRouter.of(context).go('/rest');
    }
  }

  final OutlineInputBorder _baseBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.all(Radius.circular(4)),
  );

  InputDecoration get decoration => InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      errorMaxLines: 3,
      disabledBorder: _baseBorder,
      enabledBorder: _baseBorder.copyWith(
        borderSide: const BorderSide(color: Color(0xFF00BF62), width: 1),
      ),
      focusedBorder: _baseBorder.copyWith(
        borderSide: const BorderSide(color: Colors.blueAccent, width: 1),
      ),
      errorBorder: _baseBorder.copyWith(
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ));
}

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

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 child: TextFormField(
//                   controller: _usernameController,
//                   decoration: const InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xFF00BF62))),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xFF00BF62))),
//                       labelText: "Username",
//                       labelStyle: TextStyle(color: Colors.white),
//                       errorStyle: TextStyle(
//                           color: Colors.red), // Customize error text style here
//                       errorBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color:
//                                   Colors.red)), // Customize error border here
//                       focusedErrorBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors
//                                   .red))), // Customize focused error border here
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your username'; // This message will now appear in the field itself
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 child: TextFormField(
//                   controller: _passwordController,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xFF00BF62))),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xFF00BF62))),
//                       labelText: "Password",
//                       labelStyle: TextStyle(color: Colors.white),
//                       errorStyle: TextStyle(
//                           color: Colors.red), // Customize error text style here
//                       errorBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color:
//                                   Colors.red)), // Customize error border here
//                       focusedErrorBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors
//                                   .red))), // Customize focused error border here
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your password'; // This message will now appear in the field itself
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 child: Center(
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       if (_formKey.currentState!.validate()) {
//                         bool isAuthenticated = GlobalRouter()
//                             .authenticate(_usernameController.text,
//                                 _passwordController.text);
//                         if (isAuthenticated) {
//                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                             backgroundColor: Color(0xFF00BF62),
//                             content: Text(
//                               'Logged in Successfully!',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ));
//                           GoRouter.of(context).go(RestDemoScreen.route);
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                             backgroundColor: Color(0xFF00BF62),
//                             content: Text(
//                               'Invalid username or password',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ));
//                         }
//                       }
//                     },
//                     style: ButtonStyle(
//                       backgroundColor:
//                           WidgetStateProperty.all<Color>(const Color(0xFF00BF62)),
//                     ),
//                     child: const Text('Login',
//                         style: TextStyle(color: Colors.white)),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
