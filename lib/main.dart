import 'package:flutter/material.dart';
import 'screens/menu_screen.dart';

void main() {
  runApp(const FlagGameApp());
}

class FlagGameApp extends StatelessWidget {
  const FlagGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flag Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          primary: Colors.indigo,
          secondary: Colors.amber,
        ),
        useMaterial3: true,
      ),
      home: const MenuScreen(),
    );
  }
}