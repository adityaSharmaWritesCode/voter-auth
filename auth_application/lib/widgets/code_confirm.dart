import 'package:auth_application/screens/auth_screen.dart';
import 'package:auth_application/screens/login_screen.dart';
import 'package:auth_application/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodeConfirmWidget extends StatefulWidget {
  static const route = "/codeConfirm";
  const CodeConfirmWidget({Key? key}) : super(key: key);

  @override
  State<CodeConfirmWidget> createState() => _CodeConfirmWidgetState();
}

class _CodeConfirmWidgetState extends State<CodeConfirmWidget> {
  TextEditingController? pinCodeController;
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    pinCodeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    pinCodeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Enter Pin Code Below',
            //style: FlutterFlowTheme.of(context).bodyText1,
          ),
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Confirm your Code',
                        //style: FlutterFlowTheme.of(context).title3,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(44, 8, 44, 0),
                        child: Text(
                          'This code helps keep your account safe and secure.',
                          textAlign: TextAlign.center,
                          //style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                        child: PinCodeTextField(
                          appContext: context,
                          length: 6,
                          /*textStyle: FlutterFlowTheme.of(context)
                              .subtitle2
                              .override(
                            fontFamily: 'DM Sans',
                            color: FlutterFlowTheme.of(context).primaryColor,
                          ),*/
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          enableActiveFill: false,
                          autoFocus: true,
                          showCursor: true,
                          //cursorColor: FlutterFlowTheme.of(context).primaryColor,
                          obscureText: false,
                          hintCharacter: '-',
                          pinTheme: PinTheme(
                            fieldHeight: 60,
                            fieldWidth: 60,
                            borderWidth: 2,
                            borderRadius: BorderRadius.circular(12),
                            shape: PinCodeFieldShape.box,
                          ),
                          controller: pinCodeController,
                          onChanged: (_) => {},
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
                  child: MaterialButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, AuthenticationScreen.route);
                    },
                    /*onPressed: () async {
                      GoRouter.of(context).prepareAuthEvent();
                      final smsCodeVal = pinCodeController!.text;
                      if (smsCodeVal == null || smsCodeVal.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Enter SMS verification code.'),
                          ),
                        );
                        return;
                      }
                      final phoneVerifiedUser = await verifySmsCode(
                        context: context,
                        smsCode: smsCodeVal,
                      );
                      if (phoneVerifiedUser == null) {
                        return;
                      }
    
                      context.goNamedAuth('null', mounted);
                    },*/
                    child: Text('Confirm & Continue'),
                    height: 50,
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    //color: FlutterFlowTheme.of(context).primaryText,
                    /*textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'DM Sans',
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      )*/
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
