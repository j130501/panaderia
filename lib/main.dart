import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/lista_productos_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const PanaderiaApp());
}

class PanaderiaApp extends StatelessWidget {
  const PanaderiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Panadería',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.brown),
      home: ListaProductosScreen(),
    );
  }
}
