import 'package:auth_application/screens/arvm_screen.dart';
import 'package:auth_application/screens/auth_screen.dart';
import 'package:auth_application/screens/vote_confirm_screen.dart';
import 'package:auth_application/screens/login_screen.dart';
import 'package:auth_application/widgets/barcode_scanner.dart';
import 'package:auth_application/widgets/id_scanner.dart';
import 'package:auth_application/widgets/code_confirm.dart';
import 'package:auth_application/screens/home_screen.dart';
import 'package:auth_application/widgets/login_input.dart';
import 'package:auth_application/widgets/new_scanner.dart';
import 'package:auth_application/widgets/test.dart';
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
      title: 'Mobile Voting Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFDFA69B)),
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        HomeScreen.route: (context) => const HomeScreen(),
        LoginIPWidget.route: (context) => const LoginIPWidget(),
        LoginScreen.route: (context) => const LoginScreen(),
        AuthenticationScreen.route: (context) => const AuthenticationScreen(),
        AugmentedVotingMachine.route: (context) =>
            const AugmentedVotingMachine(),
        ConfirmVoteScreen.route: (context) => const ConfirmVoteScreen(),
        CodeConfirmWidget.route: (context) => const CodeConfirmWidget(),
        idScanner.route: (context) => const idScanner(),
        BarcodeScannerWithoutController.route: (context) =>
            const BarcodeScannerWithoutController(),
        BarcodeScannerWithScanWindow.route: (context) =>
            const BarcodeScannerWithScanWindow(),
        BarcodeScannerWithController.route: (context) =>
            const BarcodeScannerWithController(),
        // LocalAndWebObjectsView.route: (context) =>
        //     const LocalAndWebObjectsView()
      },
    );
  }
}
