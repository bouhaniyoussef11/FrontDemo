import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/btn_widget.dart';
import '../components/herder_container.dart';
import '../helper/colors.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'home.dart';

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  // _RegPageState createState() => _RegPageState();
  State<StatefulWidget> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController firstNController = TextEditingController(),
      lastNController = TextEditingController(),
      phoneController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController();
  void cleartext() {
    firstNController.clear();
    lastNController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
  }

  void _registerUser() async {
    ApiResponse response = await register(
        firstNController.text,
        lastNController.text,
        phoneController.text,
        emailController.text,
        passwordController.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = !loading;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  // Save and redirect to home
  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Home()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer("Register"),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _textInput(hint: "Fullname", icon: Icons.person),
                    _textInput(hint: "Email", icon: Icons.email),
                    _textInput(hint: "Phone Number", icon: Icons.call),
                    _textInput(hint: "Password", icon: Icons.vpn_key),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          // btnText: "REGISTER",
                          onClick: () {
                            Navigator.pop(context);
                          },
                          btnText: 'Signup',
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: "Already a member ? ",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: "Login",
                            style: TextStyle(color: orangeColors)),
                      ]),
                    )
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
