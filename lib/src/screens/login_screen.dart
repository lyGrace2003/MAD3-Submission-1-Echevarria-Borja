import 'package:firebase_auth/firebase_auth.dart';
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
  late TextEditingController email, password;
  late FocusNode emailFn, passwordFn;

  bool obfuscate = true;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    email = TextEditingController();
    password = TextEditingController();
    emailFn = FocusNode();
    passwordFn = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
    emailFn.dispose();
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
                      labelText: "Email",
                      hintText: 'Enter your email address',
                      prefixIcon:
                          const Icon(Icons.person, color: Color(0xFF00BF62)),
                    ),
                    focusNode: emailFn,
                    controller: email,
                    onEditingComplete: () {
                      passwordFn.requestFocus();
                    },
                    validator: MultiValidator([
                      RequiredValidator(
                          errorText: 'Please fill out the username'),
                      MaxLengthValidator(32,
                          errorText: "Email cannot exceed 32 characters"),
                      EmailValidator(
                                errorText: "Please select a valid email"),
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

  onSubmit() async {
  if (formKey.currentState?.validate()?? false) {
    try {
      UserCredential userCredential = await AuthController.I.login(email.text.trim(), password.text.trim());
      
      if (userCredential.user!= null) {
        GoRouter.of(context).go('/rest');
      } else {
      }
    } catch (e) {
      print(e);
    }
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
