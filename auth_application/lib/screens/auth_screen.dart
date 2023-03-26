import 'package:auth_application/screens/arvm_screen.dart';
import 'package:auth_application/services/auth_services.dart';
import 'package:auth_application/test.dart';
import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationScreen extends StatefulWidget {
  static const route = "/auth";
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool authenticated = false;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Voter Authentication Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    try {
                      final XFile? photo =
                          await _picker.pickImage(source: ImageSource.camera);
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: const Text('Scan Voter ID')),
              ElevatedButton(
                onPressed: () async {
                  final check = await LocalAuth.authenticate();
                  if (authenticated) {
                    Navigator.pushNamed(context, AugmentedVotingMachine.route);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error Authenticating'),
                      ),
                    );
                  }
                  setState(() {
                    authenticated = check;
                  });
                },
                child: const Text('Authenticate Now'),
              ),

              // if (authenticated)
              //   ElevatedButton(
              //     onPressed: () {
              //       setState(
              //         () {
              //           authenticated = false;
              //         },
              //       );
              //     },
              //     child: const Text(
              //       'Congratulations! You are Authenticated!',
              //     ),
              //   )
            ],
          ),
        ),
      ),
    );
  }
}
