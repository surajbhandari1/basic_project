import 'package:flutter/material.dart';

import 'login_page.dart';

void main() {
  runApp(const LoginMe());
}

class LoginMe extends StatelessWidget {
  const LoginMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
    );
  }
}
