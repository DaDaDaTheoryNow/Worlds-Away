abstract class UsersInformationDataState<T> {
  final T? users;
  final String? error;
  const UsersInformationDataState({this.error, this.users});
}

class UsersInformationDataSuccess<T> extends UsersInformationDataState<T> {
  const UsersInformationDataSuccess(T? users) : super(users: users);
}

class UsersInformationDataError<T> extends UsersInformationDataState<T> {
  const UsersInformationDataError(String error) : super(error: error);
}
