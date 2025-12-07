import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'services/level_progress_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize level progress service before running the app
  await LevelProgressService.instance.initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Solve Equation Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const EquationGameHomeScreen(),
    );
  }
}
