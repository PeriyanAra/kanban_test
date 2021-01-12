import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(initialState) : super(initialState);

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationLoggedIn) {
      yield* _authenticationLoggedInd(event);
    } else if (event is AuthenticationLoggedOut) {
      yield* _authenticationLoggedOut(event);
    }
  }



  Stream<AuthenticationState> _authenticationLoggedInd(AuthenticationLoggedIn event) async* {
    yield AuthenticationInProgress();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', event.token);

    yield AuthenticationSuccess();
  }

  Stream<AuthenticationState> _authenticationLoggedOut(AuthenticationLoggedOut event) async* {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('token');

    yield AuthenticationFailure();
  }
}