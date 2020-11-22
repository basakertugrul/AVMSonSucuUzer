import 'package:avmv005/Model/user_model.dart';
import 'package:avmv005/Services/auth_base.dart';

class FakeAuthenticationService implements AuthBase {
  String userID = "123123123123";

  @override
  Future<User> currentUser() async {
    return await Future.value(User(userID));
  }

  @override
  Future<User> signInAnonymously() async {
    return await Future.delayed(Duration(seconds: 2), () => User(userID));
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<User> signInWithGoogle() {
    return null;
  }

  @override
  Future<User> signInWithFacebook() {
    return null;
  }
}
