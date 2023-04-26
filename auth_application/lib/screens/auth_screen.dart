import 'dart:io';

import 'package:auth_application/screens/arvm_screen.dart';
import 'package:auth_application/services/auth_services.dart';
import 'package:auth_application/widgets/barcode_scanner.dart';
import 'package:auth_application/widgets/new_scanner.dart';
import 'package:auth_application/widgets/test.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_mrz_scanner/flutter_mrz_scanner.dart';
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
  List<String> _pictures = [];
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {}

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: const Text('Voter Authentication Demo'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Visibility(
                  //   visible: uploaded,
                  //   child: Column(
                  //     children: [
                  //       for (var picture in _pictures)
                  //         SizedBox(
                  //           width: MediaQuery.of(context).size.width * 0.8,
                  //           height: MediaQuery.of(context).size.width * 0.8,
                  //           child: ClipRRect(
                  //             borderRadius: BorderRadius.circular(0),
                  //             child: Image.file(
                  //               File(picture),
                  //             ),
                  //           ),
                  //         ),
                  //     ],
                  //   ),
                  // ),
                  !uploaded
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, BarcodeScannerWithController.route);
                            setState(() {
                              uploaded = true;
                            });
                          },
                          // onPressed: () async {
                          //   List<String> pictures;
                          //   try {
                          //     pictures =
                          //         await CunningDocumentScanner.getPictures() ??
                          //             [];
                          //     if (!mounted) return;
                          //     setState(() {
                          //       _pictures = pictures;
                          //       uploaded = true;
                          //     });
                          //   } catch (e) {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(
                          //         content: Text(e.toString()),
                          //       ),
                          //     );
                          //   }
                          //   // try {
                          //   //   final XFile? photo = await _picker.pickImage(
                          //   //       source: ImageSource.camera);
                          //   //   if (photo != null) {
                          //   //     setState(() {
                          //   //       uploaded = true;
                          //   //     });
                          //   //   }
                          //   // } catch (e) {
                          //   //   ScaffoldMessenger.of(context).showSnackBar(
                          //   //     SnackBar(
                          //   //       content: Text(e.toString()),
                          //   //     ),
                          //   //   );
                          //   // }
                          // },
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
                            'Authenticate',
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
            );
          },
        ),
      ),
    );
  }
}
