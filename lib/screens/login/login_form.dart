import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* Blocs */
import 'package:kanban_test/blocs/login/bloc.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginBloc _loginBloc;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;
  String _emailErrorText = '';
  String _passwordErrorText = '';
  String _credentailsError = '';


  @override
  void initState() { 
    super.initState();
    
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }


  void _onLoginButtonPressed() async {
    FocusScope.of(context).requestFocus(FocusNode());

    bool emailHasError = false;
    bool passwordHasError = false;
    
    if (_emailController.text == '' || _emailController.text == null) {
      setState(() => _emailErrorText = 'Please input email');
      emailHasError = true;
    } else {
      setState(() => _emailErrorText = '');
      emailHasError = false;
    }

    if (_passwordController.text == '' || _passwordController.text == null) {
      setState(() => _passwordErrorText = 'Please input password');
      passwordHasError = true;
    } else {
      setState(() => _passwordErrorText = '');
      passwordHasError = false;
    }

    if (!emailHasError && !passwordHasError) {
      _loginBloc.add(
        LoginButtonPressed(
          username: _emailController.text,
          password: _passwordController.text
        ),
      );
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is LoginFailure) {
          setState(() => _credentailsError = state.error);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (BuildContext context, LoginState loginState) {
          return Container(
            child: Column(
              children: [
                // Email input section
                Container(
                  height: 56,
                  padding: EdgeInsets.only(top: 2.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF569AFF),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(76, 88, 107, 0.12),
                        blurRadius: 12.0,
                        offset: Offset(0.0, 4.0),
                      )
                    ],
                    color: Colors.white,
                  ),
                  child: TextField(
                    autocorrect: false,
                    onChanged: (String value) => setState(() {
                      _emailErrorText = '';
                      _credentailsError = '';
                    }),
                    controller: _emailController,
                    autofillHints: [AutofillHints.email],
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Color(0xFF212121), fontSize: 16),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: 14, 
                        right: 14.0,
                        bottom: 17,
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Color(0xFF569AFF),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(style: BorderStyle.none),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(style: BorderStyle.none),
                      ),
                    ),
                  ),
                ),
                if (_emailErrorText != null && _emailErrorText != '') Container(
                  margin: EdgeInsets.only(left: 14, top: 4),
                  child: Text(
                    _emailErrorText,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      letterSpacing: 0.048,
                      color: Color(0xFFFF0000),
                    ),
                  ),
                ),
                // Password input section
                Container(
                  height: 56,
                  margin: EdgeInsets.only(top: 36),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF569AFF),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(76, 88, 107, 0.12),
                        blurRadius: 12.0,
                        offset: Offset(0.0, 4.0),
                      )
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: TextFormField(
                            autocorrect: false,
                            onChanged: (String value) => setState(() {
                              _passwordErrorText = '';
                              _credentailsError = '';
                            }),
                            controller: _passwordController,
                            autofillHints: [AutofillHints.password],
                            obscureText: !_showPassword,
                            style: TextStyle(color: Color(0xFF212121), fontSize: 16.0),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 14.0, right: 14.0, bottom: 17.0, top: 0),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Color(0xFF569AFF),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(style: BorderStyle.none),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(style: BorderStyle.none),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() => _showPassword = !_showPassword);
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          margin: EdgeInsets.only(right: 12.0),
                          child: Icon(
                            _showPassword ? Icons.visibility : Icons.visibility_off,
                            color: Color(0xFF569AFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_passwordErrorText != null && _passwordErrorText != '') Container(
                  margin: EdgeInsets.only(left: 14, top: 4),
                  child: Text(
                    _passwordErrorText,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      letterSpacing: 0.048,
                      color: Color(0xFFFF0000),
                    ),
                  ),
                ),
                if (_credentailsError != '') Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 8),
                  child: Text(
                    _credentailsError,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      letterSpacing: 0.048,
                      color: Color(0xFFFF0000),
                    ),
                  ),
                ),
                // Button Section
                Container(
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    color: Color(0xFF212121),
                  ),
                  margin: EdgeInsets.only(top: 20),
                  child: Opacity(
                    opacity: loginState is LoginInProgress ? 0.6 : 1.0,
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      child: InkWell(
                        onTap: loginState is! LoginInProgress ? _onLoginButtonPressed : null,
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        child: Container(
                          child: Center(
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      )
    );
  }
}