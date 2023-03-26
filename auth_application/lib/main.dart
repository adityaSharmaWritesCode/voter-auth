import 'package:auth_application/screens/arvm_screen.dart';
import 'package:auth_application/screens/auth_screen.dart';
import 'package:auth_application/screens/scan_screen.dart';
import 'package:auth_application/services/auth_services.dart';
import 'package:auth_application/test.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voter Authentication Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthenticationScreen(),
      routes: {
        ScanScreen.route: (context) => const ScanScreen(),
        AuthenticationScreen.route: (context) => const AuthenticationScreen(),
        AugmentedVotingMachine.route: (context) =>
            const AugmentedVotingMachine(),
        // LocalAndWebObjectsView.route: (context) =>
        //     const LocalAndWebObjectsView()
      },
    );
  }
}
