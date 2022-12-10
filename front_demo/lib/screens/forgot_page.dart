import 'package:flutter/material.dart';
import 'package:front_demo/screens/regi_page.dart';

import '../components/btn_widget.dart';
// import '../components/herder_container.dart';
// import '../helper/colors.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  // _LoginPageState createState() => _LoginPageState();
  State<StatefulWidget> createState() => _ForgotPage();
}

class _ForgotPage extends State<ForgotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            // HeaderContainer("Login"),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _textInput(hint: "Email", icon: Icons.email),
                    // _textInput(hint: "Password", icon: Icons.vpn_key),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.centerRight,
                      child: const Text(
                        "Forgot Password?",
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          onClick: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RegPage()));
                          },
                          btnText: 'Send',
                          // btnText: "Send",
                        ),
                      ),
                    ),
                    // RichText(
                    //   text: TextSpan(children: [
                    //     const TextSpan(
                    //         text: "Don't have an account ? ",
                    //         style: TextStyle(color: Colors.black)),
                    //     TextSpan(
                    //         text: "Registor",
                    //         style: TextStyle(color: orangeColors)),
                    //   ]),
                    // )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textInput({controller, hint, icon}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
