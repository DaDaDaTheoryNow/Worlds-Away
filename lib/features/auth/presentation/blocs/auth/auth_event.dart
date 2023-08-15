abstract class AuthEvent {
  const AuthEvent();
}

class SignIn extends AuthEvent {
  const SignIn();
}

class SignOut extends AuthEvent {
  const SignOut();
}
