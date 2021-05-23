import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/homePage.dart';
import 'package:todo_app/pages/landingPage.dart';
import 'package:todo_app/services/authService.dart';
import 'package:todo_app/services/notifService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotifService().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        StreamProvider(
            initialData: null,
            create: (context) => context.read<AuthService>().authStateChanges)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        home: AuthRouter(),
      ),
    );
  }
}

class AuthRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User currentUser = context.watch<User>();

    if (currentUser != null) {
      return HomePage();
    }

    return LandingPage();
  }
}
