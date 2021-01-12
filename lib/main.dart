import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* Blocs */
import 'package:kanban_test/blocs/authentication/bloc.dart';
import 'package:kanban_test/blocs/login/bloc.dart';
import 'blocs/tickets/bloc.dart';

/* Screens */
import 'package:kanban_test/screens/login/index.dart';
import 'package:kanban_test/screens/homepage/index.dart';




void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => AuthenticationBloc(AuthenticationInitial()),
        ),
        BlocProvider<LoginBloc>(
          create: (BuildContext context) {
            final AuthenticationBloc _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

            return LoginBloc(
              authenticationBloc: _authenticationBloc,
              initialState: LoginInitial()
            );
          },
        ),
        BlocProvider<TicketsBloc>(
          create: (BuildContext context) => TicketsBloc(TicketsLoading()),
        ),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kanban test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, AuthenticationState authenticationState) {
          if (authenticationState is AuthenticationSuccess) {
            return HomePage();
          } else if (authenticationState is AuthenticationFailure || authenticationState is AuthenticationInitial) {
            return LoginPage();
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator()
              ),
            );
          }
        }
      )
    );
  }
}
