import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:auth_application/screens/vote_confirm_screen.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:flutter/material.dart';

class AugmentedVotingMachine extends StatefulWidget {
  static const route = "/arvm";
  const AugmentedVotingMachine({super.key});

  @override
  State<AugmentedVotingMachine> createState() => _AugmentedVotingMachineState();
}

class _AugmentedVotingMachineState extends State<AugmentedVotingMachine> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;

  ARNode? objectNode;

  bool _buttonPressed = false;

  void viewCreate(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;

    this.arSessionManager.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
          customPlaneTexturePath: "assets/triangle.png",
          //showWorldOrigin: true,
          handleTaps: true,
        );
    this.arObjectManager.onInitialize();
  }

  Future<void> onButtonPress() async {
    if (objectNode != null) {
      arObjectManager.removeNode(objectNode!);
      objectNode = null;
    } else {
      var newNode = ARNode(
          type: NodeType.localGLTF2,
          uri: "assets/Cube/Cube.gltf",
          scale: Vector3(0.15, 0.15, 0.15),
          position: Vector3(0.0, 0.0, 0.0),
          rotation: Vector4(1.0, 0.0, 0.0, 0.0));
      bool? didAddLocalNode = await arObjectManager.addNode(newNode);
      objectNode = (didAddLocalNode!) ? newNode : null;
    }
    setState(() {
      _buttonPressed = true;
    });
  }

  @override
  void dispose() {
    arSessionManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text("Augmented Voting Machine"),
        //   automaticallyImplyLeading: false,
        // ),
        body: Stack(
          children: [
            ARView(
              onARViewCreated: viewCreate,
            ),
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(22),
            //   child: ARView(
            //     onARViewCreated: viewCreate,
            //   ),
            // ),
            Positioned(
              left: 120,
              bottom: 50,
              child: !_buttonPressed
                  ? ElevatedButton(
                      onPressed: onButtonPress,
                      child: const Text("Add Voting Machine"),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(
                            context, ConfirmVoteScreen.route);
                        // setState(() {
                        //   _buttonPressed = false;
                        // });
                      },
                      child: const Text(
                        "Confirm Vote",
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
