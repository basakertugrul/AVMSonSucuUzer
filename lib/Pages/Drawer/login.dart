import 'package:avmv005/Pages/sign_in_page.dart';
import 'package:avmv005/Services/auth_base.dart';
import 'package:avmv005/commons/collapsing_navigation_drawer_widget.dart';
import 'package:avmv005/main.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final AuthBase authService;

  const LoginScreen({Key key, this.authService}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: CollapsingNavigationDrawer(),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            SignInPage(),
          ],
        ),
      ),
    );
  }
}
