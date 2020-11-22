import 'package:avmv005/Repository/user_repository.dart';
import "package:get_it/get_it.dart";

import 'Services/fake_auth_service.dart';
import 'Services/firebase_auth_service.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FakeAuthenticationService());
  locator.registerLazySingleton(() => UserRepository());
}
