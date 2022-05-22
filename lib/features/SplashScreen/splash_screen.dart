import 'package:flutter/material.dart';
import '../../UI/login_page.dart';
import '../../UI/welcome.dart';
import '../../common/shared_pref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    CheckLogInStatusAndNavigate();
  }

  CheckLogInStatusAndNavigate() async {
    bool isLoggedIn = await SharedPref.getHasUserLoggedIn();
    await Future.delayed(const Duration(seconds: 2), () {
      if (isLoggedIn) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const WelcomePage())));

        return;
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const LoginPage())));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/mylogo.png",
          height: 70,
          width: 70,
        ),
      ),
    );
  }
}
