import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:carangode_visits_app/views/formView.dart';
import 'package:flutter/material.dart';
import 'views/homeCampoView.dart'; 
import 'views/loginView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      
      initialRoute: '/login',
        routes: {
          '/login': (context) => LoginView(),
          '/campo': (context) => const HomeCampoView(),
          '/formulario': (context) => const FormView(),
        },
      );

  }
}
