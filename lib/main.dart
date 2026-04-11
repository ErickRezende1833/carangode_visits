import 'package:flutter/material.dart';
// 1. Importe o seu arquivo (ajuste o caminho se necessário)
import 'views/homeCampoView.dart'; 

void main() {
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
      
      home: const HomeCampoView(), 
    );
  }
}
