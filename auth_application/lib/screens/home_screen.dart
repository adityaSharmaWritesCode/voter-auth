import 'package:auth_application/screens/login_screen.dart';
import 'package:auth_application/widgets/login_input.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const route = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/images/ctsd-vote-homepage.jpeg',
                width: MediaQuery.of(context).size.width * 0.85,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Make a choice',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontFamily: 'Playfair Display',
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Cast your own vote and make your choice count.',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontFamily: 'DM Sans',
                                color: Color(0xC8FFFFFF),
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, LoginScreen.route);
                      },
                      height: 50,
                      color: Theme.of(context).primaryColor,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(35, 18, 35, 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2,
                      child: Text(
                        "Get Started",
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFDFA69B),
    );
  }
}
