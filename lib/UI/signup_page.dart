import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../myBloc/auth_cubit.dart';
import 'welcome.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("This is sign up page"),
        leading: const Icon(Icons.menu),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.search_sharp),
          )
        ],
      ),
      body: SingleChildScrollView(
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
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator:
                    EmailValidator(errorText: 'enter a valid email address'),
                decoration: const InputDecoration(
                    hintText: "enter your email",
                    border: OutlineInputBorder(),
                    labelText: 'Username'),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordController,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'password is required'),
                ]),
                decoration: const InputDecoration(
                    hintText: "enter your New password",
                    border: OutlineInputBorder(),
                    labelText: 'New Password'),
              ),
            ),
            MaterialButton(
              textColor: Colors.white,
              splashColor: const Color.fromARGB(255, 103, 91, 95),
              color: const Color.fromARGB(191, 5, 4, 23),
              onPressed: () {
                final formState = formKey.currentState;

                if (formState == null) {
                  print("formstate is  null");
                  return;
                }

                bool isValid = formState.validate();
                if (isValid) {
                  BlocProvider.of<AuthCubit>(context).signupWithEmail(
                      email: emailController.text,
                      password: passwordController.text);
                }
              },
              child: const Text('sign up'),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        // ),
      )),
    );
  }
}
