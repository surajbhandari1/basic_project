import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  loginWithEmail({required String email, required String password}) async {
    try {
      final userCred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e);
    }
  }

  signupWithEmail({required String email, required String password}) async {
    try {
      final userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCred.user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e);
    }
  }
}
