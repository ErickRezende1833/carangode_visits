import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'views/homeCampoView.dart';
import 'views/loginView.dart';
import 'views/formView.dart';
import 'views/cadastroEntrevistadorView.dart';
import 'views/homeGerenteView.dart';
import 'views/consultaVisitasView.dart';
import 'views/detalheVisitaView.dart';

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
      title: 'Carangode Visits',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
        ),
        useMaterial3: true,
      ),

      initialRoute: '/campo',

      routes: {
        '/campo': (context) => const HomeCampoView(),
        '/login': (context) => const LoginView(),
        '/formulario': (context) => const FormView(),
        '/cadastro-entrevistador': (context) =>
            const CadastroEntrevistadorView(),
        '/gerente': (context) => const HomeGerenteView(),
        '/consulta-visitas': (context) => const ConsultaVisitasView(),
        '/detalhe-visita': (context) => throw UnimplementedError(),
      },
    );
  }
}