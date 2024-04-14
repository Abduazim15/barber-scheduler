import 'package:barber/firebase_db_service.dart';
import 'package:barber/presentation/screens/home_page.dart';
import 'package:barber/presentation/screens/information_page.dart';
import 'package:barber/presentation/screens/login_or_register.dart';
import 'package:barber/presentation/screens/login_page.dart';
import 'package:barber/presentation/screens/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'bloc/auth_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox('auth');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  FirebaseService service = FirebaseService();
  var box = Hive.box('auth');
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(service),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        home: box.containsKey('name') ? const HomePage(): const LoginOrRegister(),
        routes: {
          '/loginOrRegister': (context) => const LoginOrRegister(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/information': (context) => const InformationPage(),
          '/home': (context) => const HomePage(),
        },
      ),
    );
  }
}
