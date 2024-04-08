import 'package:barber/firebase_db_service.dart';
import 'package:barber/presentation/screens/home_page.dart';
import 'package:barber/presentation/screens/information_page.dart';
import 'package:barber/presentation/screens/login_or_register.dart';
import 'package:barber/presentation/screens/login_page.dart';
import 'package:barber/presentation/screens/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
/*
android   1:1074360819446:android:237663516845319ee816d7
ios       1:1074360819446:ios:65f39d6be4ce34dfe816d7
*/
class MyApp extends StatelessWidget {
  MyApp({super.key});
  FirebaseService service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(service),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const LoginOrRegister(),
        routes: {
          '/loginOrRegister': (context) => LoginOrRegister(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/information': (context) => InformationPage(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}
