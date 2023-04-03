import 'package:flutter/material.dart';
import 'package:flutter_mrz_scanner/flutter_mrz_scanner.dart';

class idScanner extends StatefulWidget {
  static const route = "/idscanner";
  const idScanner({super.key});

  @override
  State<idScanner> createState() => _idScannerState();
}

class _idScannerState extends State<idScanner> {
  bool isParsed = false;
  MRZController? controller;
  @override
  void dispose() {
    controller?.stopPreview();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MRZScanner(
        withOverlay: true,
        onControllerCreated: onControllerCreated,
      ),
    );
  }

  void onControllerCreated(MRZController controller) {
    this.controller = controller;
    controller.onParsed = (result) async {
      if (isParsed) {
        return;
      }
      isParsed = true;

      await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
                  content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Document type: ${result.documentType}'),
                  Text('Given names: ${result.givenNames}'),
                  Text('Document number: ${result.documentNumber}'),
                  Text('Birthdate: ${result.birthDate}'),
                  ElevatedButton(
                    child: const Text('ok'),
                    onPressed: () {
                      isParsed = false;
                      return Navigator.pop(context, true);
                    },
                  ),
                ],
              )));
    };
    controller.onError = (error) => print(error);

    controller.startPreview();
  }
}
