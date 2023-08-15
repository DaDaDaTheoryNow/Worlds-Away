abstract class IdAvailableleDataState<T> {
  final T? isAvailable;
  final String? error;

  const IdAvailableleDataState({this.isAvailable, this.error});
}

class IdAvailableSuccess<T> extends IdAvailableleDataState<T> {
  const IdAvailableSuccess(T? isAvailable) : super(isAvailable: isAvailable);
}

class IdAvailableError<T> extends IdAvailableleDataState<T> {
  const IdAvailableError(String error) : super(error: error);
}
