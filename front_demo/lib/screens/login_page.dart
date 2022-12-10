import 'package:flutter/material.dart';
// import 'package:front_demo/components/btn_widget.dart';
import 'package:front_demo/screens/forgot_page.dart';
import 'package:front_demo/screens/regi_page.dart';
// import 'package:get/get.dart';

import '../components/herder_container.dart';
import '../constant.dart';
// import '../helper/colors.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // _LoginPageState createState() => _LoginPageState();
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool loading = false;

  void _loginUser() async {
    ApiResponse response = await login(txtEmail.text, txtPassword.text);
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
      //   body: Form(
      //     key: formkey,
      //     child: Container(
      //       padding: const EdgeInsets.only(bottom: 30),
      //       child: Column(
      //         children: <Widget>[
      //           HeaderContainer("Login"),
      //           Expanded(
      //             flex: 1,
      //             child: Container(
      //               margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
      //               child: Column(
      //                 mainAxisSize: MainAxisSize.max,
      //                 children: <Widget>[
      //                   _textInput1(hint: "Email", icon: Icons.email),
      //                   _textInput2(hint: "Password", icon: Icons.vpn_key),
      //                   Container(
      //                     margin: const EdgeInsets.only(top: 10),
      //                     alignment: Alignment.centerRight,
      //                     child: GestureDetector(
      //                       child: const Text('Forgot Password?',
      //                           style: TextStyle(color: Colors.blue)),
      //                       onTap: () => Navigator.of(context).pushAndRemoveUntil(
      //                           MaterialPageRoute(
      //                               builder: (context) => const ForgotPage()),
      //                           (route) => false),
      //                     ),
      //                   ),
      //                   loading
      //                       ? const Center(
      //                           child: CircularProgressIndicator(),
      //                         )
      //                       : kTextButton('Login', () {
      //                           if (formkey.currentState!.validate()) {
      //                             setState(() {
      //                               loading = !loading;
      //                               _loginUser();
      //                             });
      //                           }
      //                         }),
      // Expanded(
      //   child: Center(
      //     child: ButtonWidget(
      //       onClick: () {
      //         if (formkey.currentState!.validate()) {
      //           setState(() {
      //             loading = !loading;
      //             _loginUser();
      //           });
      //         }
      //       },
      //       btnText: "LOGIN",
      //     ),
      //   ),
      // ),
      //                   kLoginRegisterHint('Dont have an acount? ', 'Register',
      //                       () {
      //                     Navigator.of(context).pushAndRemoveUntil(
      //                         MaterialPageRoute(
      //                             builder: (context) => const RegPage()),
      //                         (route) => false);
      //                   })
      //                 ],
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),

      body: Form(
        key: formkey,
        child: Container(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: <Widget>[
              HeaderContainer("Login"),
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _textInput1(hint: "Email", icon: Icons.email),
                      _textInput2(hint: "Password", icon: Icons.vpn_key),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            child: const Text('Forgot Password?',
                                style: TextStyle(color: Colors.blue)),
                            onTap: () => Navigator.of(context)
                                .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPage()),
                                    (route) => false),
                          )),
                      loading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : kTextButton('Login', () {
                              if (formkey.currentState!.validate()) {
                                setState(() {
                                  loading = !loading;
                                  _loginUser();
                                });
                              }
                            }),
                      kLoginRegisterHint('Dont have an acount? ', 'Register',
                          () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const RegPage()),
                            (route) => false);
                      })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _textInput1({hint, icon}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: txtEmail,
        validator: (val) => val!.isEmpty ? 'Invalid email address' : null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  Widget _textInput2({hint, icon}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        controller: txtPassword,
        validator: (val) =>
            val!.length < 6 ? 'Required at least 6 chars' : null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
