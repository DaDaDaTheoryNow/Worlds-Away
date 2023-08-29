// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_messaging_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _FirebaseMessagingService implements FirebaseMessagingService {
  _FirebaseMessagingService(this._dio) {
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
          'Bearer ya29.c.b0Aaekm1LxfQH26Aj9zQUfugeLur9PLMa5mVc3viCXykMLOiXGnFYpOj_pWKN7_iisUsVsnJE3YrWGtLlC_hmTmsUagu_F3fow28yx04EL7clPBAb3OHsFPK_JnqM7dOFDniEp5c_E4J1Pd4xmi1WshMM0h18sv3JJS2eWx4k2LPi-60ssW8w9efbxxWbnWQ_RwPfZzo5fv4ZK00xYkMev520yqNHf3hGOW6pOJs5Eq1fBaS331f4hWkL7dlzGqde-ruSHNaiVU4teewEPG1EECmRiJQP5WCo23jxTo5ISpBecdIYNjyBQpGLAnnvEeks6vsb0TdfxVgT339Pvw66eha-p7d1d8woFbX9wraxVbSwYkkjYnuO_uiJmgZ43cohz1aSM1yVc6hJ0bV2qSe3zvyQI6Zu47rVpkzkbnogvX9p2v8Bn0hfYB6M-9w-oSWgrx259sYO385OxJttlq3Wqpohc-WwFO1IkFfJpqjmjQdOdBM6XeIcebie7SRjby2Ix-JZpY2VVs1cc0u0Urqksgan7Id7Iq88S1xFpiIF7r2ojSwVsMt0XBp4w07g9RnzweZ9t9YSbo81uZRjI3a1q8ok8n5xScOy9xtaifn2m0ZB6gbyFtvRIYqbwk7xb3mfgZraX9sh530bB9ntriyYVpZyVksre3WfipRrRImOYeSBgihl8ciXY98bqobdUWw6zpw3qQyalk5mcvSU96in0W8sBwQq_wVWwnh6yQn8XgbjxMj_mWi51XufYnOVjq3qvph0nFz42Ip2g7lpFqXJgaZtxoa8k2WgssuBXwFd5oyjprhWWjs9tZF1lUahdQmQf2xaMh-i4fUcWMf1WOeXWvROk-stUFtlMYUvvg2z7YeSu9Focl0eai5BqxWyyZFcnUnuYbUJiUl0Bx9scdtRQerOItr9OouvOxiFXV3Y8b6B-ap5JgaYtVuXogbX54enfB5ovv4gocRVYXZiwx2FQSMr27UosxaWpJ1l8ugO5650IsnFJ0Vg3gB_',
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
          '/v1/projects/worlds-away-f4aa1/messages:send',
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
