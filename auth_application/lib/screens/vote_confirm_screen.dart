import 'package:auth_application/screens/arvm_screen.dart';
import 'package:auth_application/screens/auth_screen.dart';
import 'package:flutter/material.dart';

class ConfirmVoteScreen extends StatefulWidget {
  static const route = "/confirmvote";
  const ConfirmVoteScreen({super.key});

  @override
  State<ConfirmVoteScreen> createState() => _ConfirmVoteScreenState();
}

class _ConfirmVoteScreenState extends State<ConfirmVoteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text("Confirm Vote?"),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "You have voted for XYZ Candidate.\nThis vote will be stored and recorded towards the results of the upcoming election",
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(
                          context, AugmentedVotingMachine.route);
                    },
                    child: Text("Change Vote"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("I Understand"),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
