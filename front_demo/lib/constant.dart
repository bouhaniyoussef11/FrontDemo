// ----- STRINGS ------
import 'package:flutter/material.dart';
// import 'package:front_demo/components/btn_widget.dart';

import 'helper/colors.dart';

const baseURL = 'http://172.28.32.1:8000/api';
const loginURL = '$baseURL/auth/login';
const registerURL = '$baseURL/register';
const logoutURL = '$baseURL/logout';
const userURL = '$baseURL/user';
const postsURL = '$baseURL/posts';
const commentsURL = '$baseURL/comments';

// ----- Errors -----
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';

// --- input decoration
InputDecoration kInputDecoration(String label) {
  return InputDecoration(
      labelText: label,
      contentPadding: const EdgeInsets.all(10),
      border: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black)));
}

// button

TextButton kTextButton(String label, Function onPressed) {
  return TextButton(
    style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.blue),
        padding: MaterialStateProperty.resolveWith(
            (states) => const EdgeInsets.symmetric(vertical: 10))),
    onPressed: () => onPressed(),
    child: Text(
      label,
      style: const TextStyle(color: Colors.white),
    ),
  );
}

// loginRegisterHint
Container kLoginRegisterHint(String text, String label, Function onTap) {
  return Container(
    margin: const EdgeInsets.only(left: 80, right: 20, top: 30),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(text: text, style: const TextStyle(color: Colors.black)),
            // TextSpan(text: "Registor", style: TextStyle(color: orangeColors)),
          ]),
        ),
        // Text(text),
        GestureDetector(
            child: Text(label, style: TextStyle(color: orangeColors)),
            onTap: () => onTap())
      ],
    ),
  );
}

Row kLoginRegisterHint1(String label, Function onTap) {
  return Row(
    children: [
      GestureDetector(
          child: Text(label, style: const TextStyle(color: Colors.blue)),
          onTap: () => onTap())
    ],
  );
}

// likes and comment btn

Expanded kLikeAndComment(
    int value, IconData icon, Color color, Function onTap) {
  return Expanded(
    child: Material(
      child: InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              const SizedBox(width: 4),
              Text('$value')
            ],
          ),
        ),
      ),
    ),
  );
}

const kPrimaryColor = Color(0xFF1B383A);
const kSecondaryColor = Color(0xFF59706F);
const kDarkGreyColor = Color(0xFFA8A8A8);
const kWhiteColor = Color(0xFFFFFFFF);
const kZambeziColor = Color(0xFF5B5B5B);
const kBlackColor = Color(0xFF272726);
const kTextFieldColor = Color(0xFF979797);

const kDefaultPadding = EdgeInsets.symmetric(horizontal: 30);

TextStyle titleText = const TextStyle(
    color: kPrimaryColor, fontSize: 32, fontWeight: FontWeight.w700);
TextStyle subTitle = const TextStyle(
    color: kSecondaryColor, fontSize: 18, fontWeight: FontWeight.w500);
TextStyle textButton = const TextStyle(
  color: kPrimaryColor,
  fontSize: 18,
  fontWeight: FontWeight.w700,
);
