import 'package:avmv005/Model/user_model.dart';
import 'package:avmv005/View_Model/user_model.dart';
import 'package:avmv005/commons/collapsing_navigation_drawer_widget.dart';
import 'package:avmv005/main.dart';
import 'package:avmv005/widgets/common_widget/social_login_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  void _misafirGirisi(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context);
    // ignore: unused_local_variable
    User _user = await _userModel.signInAnonymously();
    print("Oturum açan user id:");
  }

  void _googleIleGiris(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context);
    // ignore: unused_local_variable
    User _user = await _userModel.signInWithGoogle();
    print("Oturum açan user id:");
  }

  void _facebookIleGiris(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context);
    // ignore: unused_local_variable
    User _user = await _userModel.signInWithFacebook();
    print("Oturum açan user id:");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: CollapsingNavigationDrawer(),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "Oturum Aç",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SocialLoginButton(
                    buttonColor: Colors.white,
                    buttonText: "Google ile Giriş Yap",
                    textColor: Colors.black87,
                    radius: 16.0,
                    onPressed: () => {_googleIleGiris(context)},
                    buttonIcon: Image.asset("images/google-logo.png"),
                  ),
                  SocialLoginButton(
                    buttonColor: Color(0xFF334D92),
                    buttonText: "Facebook ile Giriş Yap",
                    textColor: Colors.white,
                    radius: 16.0,
                    onPressed: () => {_facebookIleGiris(context)},
                    buttonIcon: Image.asset("images/facebook-logo.png"),
                  ),
                  /* SocialLoginButton(
                    buttonColor: Colors.deepPurple,
                    buttonText: "Email ve Şifre ile Giriş Yap",
                    textColor: Colors.white,
                    radius: 16.0,
                    onPressed: () => {_emailVeSifreGiris(context)},
                    buttonIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),*/
                  SocialLoginButton(
                    buttonColor: Colors.teal,
                    buttonText: "Misafir Girişi Yap",
                    textColor: Colors.white,
                    radius: 16.0,
                    onPressed: () => _misafirGirisi(context),
                    buttonIcon: Icon(
                      Icons.accessibility_new,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
