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
  bool uploaded = false;
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
              !uploaded
                  ? ElevatedButton(
                      onPressed: () async {
                        try {
                          final XFile? photo = await _picker.pickImage(
                              source: ImageSource.camera);
                          setState(() {
                            uploaded = true;
                          });
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                      child: Text(
                        'Scan Voter ID',
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: Colors.white, fontSize: 20),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        final check = await LocalAuth.authenticate();

                        setState(() {
                          authenticated = check;
                        });
                        if (authenticated) {
                          Navigator.pushNamed(
                              context, AugmentedVotingMachine.route);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error Authenticating'),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Authenticate Now',
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: Colors.white, fontSize: 20),
                      ),
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
