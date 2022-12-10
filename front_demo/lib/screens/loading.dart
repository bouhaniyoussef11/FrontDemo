import 'package:flutter/material.dart';
import 'package:front_demo/screens/login_page.dart';

import '../constant.dart';
import '../models/api_response.dart';
import '../services/user_service.dart';
import 'home.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  // _LoadingState createState() => _LoadingState();
  State<StatefulWidget> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void _loadUserInfo() async {
    String token = await getToken();
    if (token == '') {
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false);
    } else {
      ApiResponse response = await getUserDetail();
      if (response.error == null) {
        if (!mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Home()),
            (route) => false);
      } else if (response.error == unauthorized) {
        if (!mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.error}'),
        ));
      }
    }
  }

  @override
  void initState() {
    _loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
