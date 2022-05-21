import 'package:flutter/material.dart';
import '../myBloc/auth_cubit.dart';
import '../myBloc/auth_state.dart';
import '../ui/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
      body: Column(children: [
        Image.network(
            'https://i.picsum.photos/id/35/250/250.jpg?hmac=pibaNEIwE4JoxHZkwQ24nBAo8E_k9KHXl5FrZ2zdj8Q'),
        BlocListener<AuthCubit, AuthState>(
          child: MaterialButton(
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).logOut();
              },
              child: const Text('Log Out')),
          listener: (context, state) {
            if (state is LogOutState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: ((context) => const LoginPage())));
            }
          },
        )
      ]),
    );
  }
}
