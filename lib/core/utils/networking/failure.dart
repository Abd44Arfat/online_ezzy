import 'package:dio/dio.dart';

class Failure {
  final String message;

  Failure(this.message);

  factory Failure.fromDioException(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return Failure('تم إلغاء الطلب قبل تنفيذه.');

      case DioExceptionType.connectionTimeout:
        return Failure('انتهت مهلة الاتصال بالخادم. حاول مرة أخرى.');

      case DioExceptionType.sendTimeout:
        return Failure('انتهت مهلة إرسال البيانات إلى الخادم.');

      case DioExceptionType.receiveTimeout:
        return Failure('انتهت مهلة انتظار البيانات من الخادم.');

      case DioExceptionType.badCertificate:
        return Failure('شهادة الأمان غير صالحة. تأكد من الاتصال الآمن.');

      case DioExceptionType.connectionError:
        return Failure('لا يوجد اتصال بالإنترنت. تحقق من الشبكة.');

      case DioExceptionType.unknown:
        return Failure('حدث خطأ غير متوقع. حاول مرة أخرى.');

      case DioExceptionType.badResponse:
        return _handleBadResponse(dioError.response);

      default:
        return Failure('حدث خطأ غير متوقع.');
    }
  }

  static Failure _handleBadResponse(Response? response) {
    final statusCode = response?.statusCode;
    
    // Try to extract the actual error message from the response
    String errorMessage = 'حدث خطأ غير متوقع من الخادم. رمز الخطأ: $statusCode';
    
    if (response?.data != null && response!.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;
      
      // Check for different possible error message fields
      if (data['Message'] != null) {
        errorMessage = data['Message'].toString();
      } else if (data['message'] != null) {
        errorMessage = data['message'].toString();
      } else if (data['error'] != null) {
        errorMessage = data['error'].toString();
      } else if (data['Error'] != null) {
        errorMessage = data['Error'].toString();
      }
    }
    
    switch (statusCode) {
      case 400:
        return Failure(errorMessage.isNotEmpty ? errorMessage : 'الطلب غير صالح. تحقق من البيانات.');
      case 401:
        return Failure(errorMessage.isNotEmpty ? errorMessage : 'غير مصرح لك. يرجى تسجيل الدخول مجددًا.');
      case 403:
        return Failure(errorMessage.isNotEmpty ? errorMessage : 'ليس لديك صلاحية الوصول إلى هذا المورد.');
      case 404:
        return Failure(errorMessage.isNotEmpty ? errorMessage : 'العنصر المطلوب غير موجود.');
      case 405:
        return Failure(errorMessage.isNotEmpty ? errorMessage : 'طريقة الطلب غير مسموح بها. حاول باستخدام طريقة أخرى.');
      case 409:
        return Failure(errorMessage.isNotEmpty ? errorMessage : 'يوجد تعارض في البيانات. قد يكون العنصر مكررًا.');
      case 422:
        return Failure(errorMessage.isNotEmpty ? errorMessage : 'البيانات المُدخلة غير صحيحة. يرجى التحقق.');
      case 500:
        return Failure(errorMessage.isNotEmpty ? errorMessage : 'خطأ داخلي في الخادم. حاول لاحقًا.');
      case 503:
        return Failure(errorMessage.isNotEmpty ? errorMessage : 'الخدمة غير متوفرة حاليًا. حاول لاحقًا.');
      case 504:
        return Failure(errorMessage.isNotEmpty ? errorMessage : 'انتهت مهلة الاتصال بالخادم.');
      default:
        return Failure(errorMessage.isNotEmpty ? errorMessage : 'حدث خطأ غير متوقع من الخادم. رمز الخطأ: $statusCode');
    }
  }
}