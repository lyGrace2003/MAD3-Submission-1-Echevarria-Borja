import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:midterm_project/src/controllers/auth_controller.dart';
import 'package:midterm_project/src/dialogs/waiting_dialog.dart';
class RegistrationScreen extends StatefulWidget {
  static const String route = "/register";

  static const String name = "Registration Screen";
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController name, email, password;
  late FocusNode nameFn, emailFn, passwordFn;

  bool obfuscate = true;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    nameFn = FocusNode();
    emailFn = FocusNode();
    passwordFn = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    email.dispose();
    password.dispose();
    nameFn.dispose();
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
        title: const Text('Register', style: TextStyle(color: Colors.white),),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.only(bottom: 16),
          height: 52,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFF00BF62)),
            ),
            onPressed: () {
              onSubmit();
            },
            child: const Text(
              'Register',
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
                      labelText: "Name",
                      hintText: 'Enter your name',
                      prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF00BF62)),
                    ),
                    focusNode: nameFn,
                    controller: name,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Please enter your name'),
                    ]).call,
                  ),
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: TextFormField(
                    decoration: decoration.copyWith(
                      labelText: "Email",
                      hintText: 'Enter your email address',
                      prefixIcon: const Icon(Icons.email, color: Color(0xFF00BF62)),
                    ),
                    focusNode: emailFn,
                    controller: email,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Please fill out the email'),
                      EmailValidator(errorText: "Please enter a valid email"),
                    ]).call,
                  ),
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obfuscate,
                    decoration: decoration.copyWith(
                      labelText: "Password",
                      hintText: 'Enter your password',
                      prefixIcon: const Icon(Icons.lock, color: Color(0xFF00BF62)),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obfuscate =!obfuscate;
                          });
                        },
                        icon: Icon(obfuscate? Icons.visibility_off : Icons.visibility),
                      ),
                    ),
                    focusNode: passwordFn,
                    controller: password,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Password is required"),
                      MinLengthValidator(12, errorText: "Password must be at least 12 characters long"),
                      MaxLengthValidator(128, errorText: "Password cannot exceed 128 characters"),
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
      UserCredential userCredential = await AuthController.I.register(email.text.trim(), password.text.trim());

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
      enabledBorder: _baseBorder.copyWith(borderSide: const BorderSide(color: Color(0xFF00BF62), width: 1)),
      focusedBorder: _baseBorder.copyWith(borderSide: const BorderSide(color: Colors.blueAccent, width: 1)),
      errorBorder: _baseBorder.copyWith(borderSide: const BorderSide(color: Colors.red, width: 1)),
  );
}