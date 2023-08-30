// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_messaging_retrofit.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _FirebaseMessagingRetrofit implements FirebaseMessagingRetrofit {
  _FirebaseMessagingRetrofit(this._dio) {
    baseUrl ??= 'https://fcm.googleapis.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<void> createRequest(FirebaseNotificationModel notification) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Authorization':
          'key=AAAAIOhfKPI:APA91bFD-8sy1-Ce4f0cS4BODjxUlmO-r2Nqa0LZ3z2DEll0TCz4pz_ey-dXfZQXa6lbDe6oX57Ens2Dpt7rb3nThgZ6gJvzrVmTdkRK1ow6qUhOzu-MR9AIHA5uaxzJKWcR56T7LfzD',
      r'Content-Type': 'application/json',
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(notification.toJson());
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
        .compose(
          _dio.options,
          '/fcm/send',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
