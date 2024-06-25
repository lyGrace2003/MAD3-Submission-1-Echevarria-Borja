import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String route = 'auth';
  static const String path = "/auth";

  static const String name = 'LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Login Page"),
    );
  }
}