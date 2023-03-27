import 'package:auth_application/screens/arvm_screen.dart';
import 'package:auth_application/screens/auth_screen.dart';
import 'package:auth_application/screens/login_screen.dart';
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
      home: const LoginScreen(),
      routes: {
        LoginScreen.route: (context) => const LoginScreen(),
        AuthenticationScreen.route: (context) => const AuthenticationScreen(),
        AugmentedVotingMachine.route: (context) =>
            const AugmentedVotingMachine(),
        // LocalAndWebObjectsView.route: (context) =>
        //     const LocalAndWebObjectsView()
      },
    );
  }
}
