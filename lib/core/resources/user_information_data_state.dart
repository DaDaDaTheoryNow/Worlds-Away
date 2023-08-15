abstract class UserInformationDataState<T> {
  final T? user;
  final String? error;
  const UserInformationDataState({this.error, this.user});
}

class UserInformationDataSuccess<T> extends UserInformationDataState<T> {
  const UserInformationDataSuccess(T? user) : super(user: user);
}

class UserInformationDataError<T> extends UserInformationDataState<T> {
  const UserInformationDataError(String error) : super(error: error);
}
