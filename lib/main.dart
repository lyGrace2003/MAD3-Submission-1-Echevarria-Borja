import 'package:flutter/material.dart';
import 'package:midterm_project/src/screens/rest_screen.dart';
import 'package:provider/provider.dart';
import 'package:midterm_project/src/routing/router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalRouter _globalRouter = GlobalRouter();

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerDelegate: _globalRouter.router.routerDelegate,
      routeInformationParser: _globalRouter.router.routeInformationParser,
      routeInformationProvider: _globalRouter.router.routeInformationProvider,
    );
  }
}
