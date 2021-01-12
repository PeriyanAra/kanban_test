import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* Blocs */
import 'package:kanban_test/blocs/authentication/bloc.dart';

/* Services */
import 'package:kanban_test/services/authentication_repository.dart';

import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authenticationBloc;
  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();

  LoginBloc({
    @required initialState,
    @required this.authenticationBloc,
  }) : super(initialState);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield* _loginButtonPressed(event);
    }
  }



  Stream<LoginState> _loginButtonPressed(LoginButtonPressed event) async* {
    yield LoginInProgress();

    final Map authResponse = await _authenticationRepository.authenticate(
      username: event.username,
      password: event.password
    );

    if (authResponse['token'] != null) {
      authenticationBloc.add(
        AuthenticationLoggedIn(token: authResponse['token'])
      );
      yield LoginInitial();
    } else {
      yield LoginFailure(
        error: authResponse[authResponse.keys.first][0]
      );
    }
  }
}