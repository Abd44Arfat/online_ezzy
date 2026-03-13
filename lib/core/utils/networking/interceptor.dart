import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// This interceptor is used to show request and response logs
class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: true,printEmojis: true));

  @override
  void onError( DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final fullUri = options.uri; // includes query params
    logger.e('${options.method} request ==> $fullUri'); //Error log
    if (options.queryParameters.isNotEmpty) {
      logger.i('QUERY: ${options.queryParameters}');
    }
    if (options.data != null) {
      logger.d('BODY: ${options.data}');
    }
    if (err.response != null) {
      logger.e('STATUSCODE: ${err.response?.statusCode}');
      logger.e('ERROR_DATA: ${err.response?.data}');
      logger.e('ERROR_HEADERS: ${err.response?.headers}');
    }
    logger.d('Error type: ${err.error} \n '
        'Error message: ${err.message}'); //Debug log
    handler.next(err); //Continue with the Error
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final fullUri = options.uri; // includes query params
    logger.i('${options.method} request ==> $fullUri'); //Info log
    if (options.queryParameters.isNotEmpty) {
      logger.i('QUERY: ${options.queryParameters}');
    }
    if (options.data != null) {
      logger.d('BODY: ${options.data}');
    }
    handler.next(options); // continue with the Request
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('STATUSCODE: ${response.statusCode} \n '
        'STATUSMESSAGE: ${response.statusMessage} \n'
        'HEADERS: ${response.headers} \n'
        'Data: ${response.data}'); // Debug log
    handler.next(response); // continue with the Response
  }
}