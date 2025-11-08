import 'package:hi_net/app/app.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:hi_net/app/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app/services/app_preferences.dart';

const String APPLICATION_JSON = 'application/json';
const String CONTENT_TYPE = 'content-type';
const String ACCEPT = 'accept';
const String AUTHORIZATION = 'authorization';
const String DEFAULT_LANGUAGE = 'Accept-Language';
const String SECRET_KEY = "Accept-Secret-Key";

enum RequestMethod { GET, POST, PUT, DELETE, PATCH }

class DioFactory {
  late Dio _dio;
  AppPreferences _appPreferences;
  bool isForNotification;

  Dio get dio => _dio;

  DioFactory(this._appPreferences, {this.isForNotification = false}) {
    _dio = Dio();

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: 'Bearer ${_appPreferences.token}',
      DEFAULT_LANGUAGE: 'en',
      SECRET_KEY: "zAyuqt8Fb#&*t-rnL3q%\$"
    };

    _dio.options = BaseOptions(
        baseUrl: Constants.baseUrl,
        headers: headers,
        followRedirects: false,
        receiveDataWhenStatusError: true);

    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      if (_appPreferences.token != null) {
        options.headers['Authorization'] = 'Bearer ${_appPreferences.token}';
      }
      if (SCAFFOLD_MESSENGER_KEY.currentState != null) {
        options.headers[DEFAULT_LANGUAGE] =
            EasyLocalization.of(SCAFFOLD_MESSENGER_KEY.currentState!.context)
                    ?.currentLocale
                    ?.languageCode ??
                'en';
      }
      return handler.next(options);
    }, onError: (DioException e, handler) async {
      // if (e.response?.statusCode == 401 &&
      //     e.response?.data is Map<String, dynamic> &&
      //     e.response?.data['message'] == "غير مصرح" &&
      //     _appPreferences.refreshToken != null) {
      //   Either<Failure, RefreshTokenResponse> response =
      //       await instance<RefreshTokenUseCase>().execute(RefreshTokenRequest(
      //     refreshToken: _appPreferences.refreshToken!,
      //   ));

      //   return response.fold((failure) async {
      //     if (failure is CustomServerError &&
      //         failure.error == ApiErrorType.INVALID_REFRESH_TOKEN) {
      //       // if request for getting notification in background services
      //       // so avoid navigating to register screen
      //       if (isForNotification) return;
      //       await _appPreferences.clearAllTokens();
      //       await _appPreferences.sharedPreferences.reload();
      //       // await NAVIGATOR_KEY.currentState?.pushNamedAndRemoveUntil(
      //       //     RoutesManager.register.route, (route) => false);
      //       return handler.reject(e);
      //     }
      //     return handler.next(e);
      //   }, (response) async {
      //     // Store the new token
      //     await _appPreferences.setToken(response.accessToken);
      //     await _appPreferences.setIdToken(response.idToken);
      //     await _appPreferences.sharedPreferences.reload();

      //     if (e.requestOptions.headers['Content-Type']
      //         ?.startsWith('multipart/form-data')) {
      //       e.requestOptions.data = (e.requestOptions.data as FormData).clone();
      //     }

      //     e.requestOptions.headers['Authorization'] =
      //         "Bearer ${_appPreferences.token}";

      //     // Retry the original request
      //     return handler.resolve(await _dio.fetch(e.requestOptions));
      //   });
      // }

      // For all other errors, just propagate them
      return handler.next(e);
    }));

    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true));
    }
  }

  Future<Response> request(String path,
      {RequestMethod method = RequestMethod.GET,
      Map<String, dynamic>? queryParameters,
      Object? body,
      Map<String, dynamic>? headers}) async {
    return await _dio.request(path,
        data: body,
        queryParameters: queryParameters,
        options: Options(method: method.name, headers: headers));
  }
}
