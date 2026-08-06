import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'views/splash_screen.dart';
import 'widgets/connectivity_gate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const BloodConnectApp());
}

class BloodConnectApp extends StatelessWidget {
  const BloodConnectApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BloodConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        fontFamily: 'Cairo',
      ),
      builder: (context, child) => ConnectivityGate(child: child ?? const SizedBox.shrink()),
      home: const SplashScreen(),
    );
  }
}
