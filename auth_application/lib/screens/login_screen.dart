import 'package:auth_application/screens/auth_screen.dart';
import 'package:auth_application/widgets/login_input.dart';
import 'package:auth_application/widgets/register_input.dart';
import 'package:flutter/material.dart';
import 'package:tab_container/tab_container.dart';

class LoginScreen extends StatefulWidget {
  static const route = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TabContainerController _controller;

  @override
  void initState() {
    _controller = TabContainerController(length: 2);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: AspectRatio(
                  aspectRatio: 10 / 17,
                  child: TabContainer(
                    radius: 20,
                    tabEdge: TabEdge.top,
                    tabCurve: Curves.easeIn,
                    colors: <Color>[
                      Theme.of(context).primaryColorLight,
                      //Color(0xfffa86be),
                      Theme.of(context).colorScheme.secondaryContainer,
                      //Color(0xffa275e3),
                    ],
                    selectedTextStyle: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(fontSize: 18.0),
                    unselectedTextStyle: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(fontSize: 12.0),
                    children: [LoginIPWidget(), RegisterIPWidget()],
                    tabs: const ["Log-in", "Register"],
                  ),
                ),
              ),
              // Text(
              //   "Login",
              //   style: Theme.of(context)
              //       .textTheme
              //       .displayMedium!
              //       .copyWith(color: Colors.black),
              // ),
              // TextFormField(
              //   decoration: InputDecoration(
              //     hintText: "Voter ID Card number",
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(20),
              //       borderSide: const BorderSide(width: 2),
              //     ),
              //   ),
              // ),
              // TextFormField(
              //   keyboardType: TextInputType.number,
              //   maxLength: 10,
              //   decoration: InputDecoration(
              //     hintText: "Phone Number",
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(20),
              //       borderSide: const BorderSide(width: 2),
              //     ),
              //   ),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.of(context)
              //         .popAndPushNamed(AuthenticationScreen.route);
              //   },
              //   child: Text(
              //     "Submit",
              //     style: Theme.of(context)
              //         .textTheme
              //         .button!
              //         .copyWith(color: Colors.white, fontSize: 20),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> _getChildren1() {
  List<CreditCardData> cards = kCreditCards
      .map(
        (e) => CreditCardData.fromJson(e),
      )
      .toList();

  return cards.map((e) => CreditCard(data: e)).toList();
}

class CreditCard extends StatelessWidget {
  final Color? color;
  final CreditCardData data;

  const CreditCard({
    Key? key,
    this.color,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.bank,
                ),
                Icon(
                  data.number[0] == '4'
                      ? Icons.visibility_sharp
                      : data.number[0] == '5'
                          ? Icons.card_giftcard
                          : Icons.question_answer,
                  size: 36,
                ),
              ],
            ),
          ),
          const Spacer(flex: 2),
          Expanded(
            flex: 5,
            child: Row(
              children: [
                Text(
                  data.number,
                  style: const TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Exp.'),
                const SizedBox(width: 4),
                Text(
                  data.expiration,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CreditCardData {
  int index;
  bool locked;
  final String bank;
  final String name;
  final String number;
  final String expiration;
  final String cvc;

  CreditCardData({
    this.index = 0,
    this.locked = false,
    required this.bank,
    required this.name,
    required this.number,
    required this.expiration,
    required this.cvc,
  });

  factory CreditCardData.fromJson(Map<String, dynamic> json) => CreditCardData(
        index: json['index'],
        bank: json['bank'],
        name: json['name'],
        number: json['number'],
        expiration: json['expiration'],
        cvc: json['cvc'],
      );
}

const List<Map<String, dynamic>> kCreditCards = [
  {
    'index': 0,
    'bank': 'Aerarium',
    'name': 'John Doe',
    'number': '4540 1234 5678 2975',
    'expiration': '11/25',
    'cvc': '123',
  },
  {
    'index': 1,
    'bank': 'Aerarium',
    'name': 'John Doe',
    'number': '5450 8765 4321 6372',
    'expiration': '07/24',
    'cvc': '321',
  },
];
