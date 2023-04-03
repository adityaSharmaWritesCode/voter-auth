import 'package:auth_application/widgets/code_confirm.dart';
import 'package:flutter/material.dart';

class LoginIPWidget extends StatefulWidget {
  static const route = "/loginIP";
  const LoginIPWidget({Key? key}) : super(key: key);

  @override
  State<LoginIPWidget> createState() => _LoginIPWidgetState();
}

class _LoginIPWidgetState extends State<LoginIPWidget>
    with TickerProviderStateMixin {
  TextEditingController? phoneNumberController;
  String? Function(BuildContext, String?)? phoneNumberControllerValidator;

  @override
  void dispose() {
    phoneNumberController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(
                    'Enter your details below to sign in.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 15.0,
                        ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
            child: TextFormField(
              controller: phoneNumberController,
              obscureText: false,
              maxLength: 10,
              decoration: InputDecoration(
                labelText: 'Voter ID',
                labelStyle: Theme.of(context).textTheme.labelLarge,
                hintText: 'Please enter a valid ID number',
                hintStyle: Theme.of(context).textTheme.labelSmall,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).dialogBackgroundColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                filled: true,
                fillColor: Theme.of(context).secondaryHeaderColor,
                contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
              ),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontFamily: 'DM Sans',
                    color: Color(0xFF0F1113),
                  ),
              maxLines: null,
              keyboardType: TextInputType.phone,
              //validator: phoneNumberControllerValidator?.asValidator(context),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
            child: MaterialButton(
              onPressed: () async {
                final phoneNumberVal = phoneNumberController?.text;
                print(phoneNumberVal);
                if (phoneNumberVal == null ||
                    phoneNumberVal.isEmpty ||
                    !phoneNumberVal.startsWith('+')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Phone Number is required and has to start with +.'),
                    ),
                  );
                  //return;
                }
                /*await beginPhoneAuth(
                      context: context,
                      phoneNumber: phoneNumberVal,
                      onCodeSent: () async {
                        context.goNamedAuth(
                          'code_confirm',
                          mounted,
                          ignoreRedirect: true,
                        );
                      },
                    );*/
                Navigator.pushNamed(context, CodeConfirmWidget.route);
              },
              height: 50,
              color: Theme.of(context).primaryColorDark,
              //color: Theme.of(context).colorScheme.tertiaryContainer,
              textTheme: Theme.of(context).buttonTheme.textTheme,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
              child: Text(
                'Sign In',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontFamily: 'DM Sans',
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
