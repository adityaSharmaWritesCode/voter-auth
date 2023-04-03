import 'dart:io';

import 'package:auth_application/screens/arvm_screen.dart';
import 'package:auth_application/services/auth_services.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mrz_scanner/flutter_mrz_scanner.dart';

class AuthenticationScreen extends StatefulWidget {
  static const route = "/auth";
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool uploaded = false;
  bool authenticated = false;
  List<String> _pictures = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: const Text('Voter Authentication Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Visibility(
                visible: uploaded,
                child: Column(
                  children: [
                    for (var picture in _pictures)
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: Image.file(
                            File(picture),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              !uploaded
                  ? ElevatedButton(
                      onPressed: () async {
                        List<String> pictures;
                        try {
                          pictures =
                              await CunningDocumentScanner.getPictures() ?? [];
                          if (!mounted) return;
                          setState(() {
                            _pictures = pictures;
                            uploaded = true;
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
                        // try {
                        //   final XFile? photo = await _picker.pickImage(
                        //       source: ImageSource.camera);
                        //   if (photo != null) {
                        //     setState(() {
                        //       uploaded = true;
                        //     });
                        //   }
                        // } catch (e) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text(e.toString()),
                        //     ),
                        //   );
                        // }
                      },
                      child: Text(
                        'Scan Voter ID',
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(fontSize: 20),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        try {
                          final check = await LocalAuth.authenticate();
                          setState(() {
                            authenticated = check;
                          });
                          if (authenticated) {
                            Navigator.pushNamed(
                                context, AugmentedVotingMachine.route);
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Authenticate Now',
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(fontSize: 20),
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
