import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';
import '../common/shared_pref.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  loginWithEmail({required String email, required String password}) async {
    try {
      final userCred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(AuthSuccessState());

      
      SharedPref.setHasUserLoggedIn(true);

      final bool LoggedIn = await SharedPref.getHasUserLoggedIn();
      print("....From Login.....");
      print("$LoggedIn");
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(errorMessage: e.toString()));
    }
  }

  signupWithEmail({required String email, required String password}) async {
    try {
      emit(AuthSignupSuccessState());
      final userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
    } catch (e) {}
  }

  logOut() async {
    SharedPref.setHasUserLoggedIn(false);
    SharedPref.clearAllData();

    final bool LoggedIn = await SharedPref.getHasUserLoggedIn();
    print("....From Logout.....");
    print("$LoggedIn");
    emit(LogOutState());
  }

  check() async {
    final bool check = await SharedPref.getHasUserLoggedIn();
    print("$check");
  }
}
