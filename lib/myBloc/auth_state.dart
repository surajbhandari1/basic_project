abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {
  final String loadingMessage;
  AuthLoadingState({required this.loadingMessage});
}

class AuthErrorState extends AuthState {
  final String errorMessage;
  AuthErrorState({required this.errorMessage});
}

class AuthSuccessState extends AuthState {
  final data;
  AuthSuccessState({this.data});
}
