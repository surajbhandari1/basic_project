import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:master_project/UI/signup_page.dart';
import 'package:master_project/UI/welcome.dart';
import '../myBloc/auth_cubit.dart';
import '../myBloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.search_sharp),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: BlocListener<AuthCubit, AuthState>(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 100, 50, 50),
                  child: Image.network(
                      'https://img.icons8.com/external-bearicons-gradient-bearicons/64/000000/external-login-call-to-action-bearicons-gradient-bearicons-1.png'),
                ),
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.all(8.0),

                  //Input Field for email address
                  child: TextFormField(
                    controller: emailController,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Email is required'),
                      EmailValidator(errorText: 'Enter a valid email address'),
                    ]),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your email'),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),

                  //Input Field for password
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Password is required'),
                    ]),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your password'),
                  ),
                ),
                MaterialButton(
                  child: const Text('Login'),
                  textColor: Colors.white,
                  splashColor: const Color.fromARGB(255, 103, 91, 95),
                  color: const Color.fromARGB(191, 5, 4, 23),
                  onPressed: () {
                    final formState = formKey.currentState;
                    if (formState == null) {
                      return;
                    }

                    bool isValid = formState.validate();
                    if (isValid) {
                      BlocProvider.of<AuthCubit>(context).loginWithEmail(
                          email: emailController.text,
                          password: passwordController.text);
                    }

                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: ((context) => const WelcomePage())));
                  },
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: MaterialButton(
                          onPressed: () {},
                          child: const Text('Login with Google')),
                    ),
                    Padding(
                      padding: EdgeInsets.all(30.0),
                      child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupPage()));
                          },
                          child: Text('sign up')),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          listener: (context, state) {
            if (state is AuthErrorState) {
              Fluttertoast.showToast(
                msg: state.errorMessage, // this show actual error from firebase
                // msg: "Email or Password is invalid", // This show costom messsage inplace of any error occour.
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: Colors.blueAccent,
              );
            }
            if (state is AuthSuccessState) {
              Fluttertoast.showToast(
                msg: "Successfully Logged in",
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: Colors.greenAccent,
              );

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const WelcomePage())));
            }
          },
        ),
      ),
    );
  }
}
