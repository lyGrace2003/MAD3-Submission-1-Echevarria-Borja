import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:midterm_project/src/screens/rest_screen.dart';
import 'package:provider/provider.dart';
import 'package:midterm_project/src/routing/router.dart';
import 'package:midterm_project/src/controllers/auth_controller.dart';

void main() async {
  await Hive.initFlutter();
  AuthController.initialize();
  GlobalRouter.initialize();

  /// await AuthController.I.loadSession();

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
    final GlobalRouter globalRouter = GlobalRouter();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      routerDelegate: globalRouter.router.routerDelegate,
      routeInformationParser: globalRouter.router.routeInformationParser,
      routeInformationProvider: globalRouter.router.routeInformationProvider,
    );
  }
}
