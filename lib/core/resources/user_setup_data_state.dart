abstract class UserSetupDataState<T> {
  final String? error;
  const UserSetupDataState({this.error});
}

class UserSetupDataSuccess<T> extends UserSetupDataState<T> {
  const UserSetupDataSuccess();
}

class UserSetupDataFailed<T> extends UserSetupDataState<T> {
  const UserSetupDataFailed();
}

class UserSetupDataError<T> extends UserSetupDataState<T> {
  const UserSetupDataError(String error) : super(error: error);
}
