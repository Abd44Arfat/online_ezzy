import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:online_ezzy/core/utils/networking/api_constants.dart';
import 'package:online_ezzy/core/utils/networking/dio_helper.dart';
import 'package:online_ezzy/core/utils/networking/failure.dart';
import 'package:online_ezzy/data/Models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final DioClient api;

  AuthRepository(this.api);

  Future<Either<Failure, LoginResponse>> userEmailLogin(
    String email,
    String password,
  ) async {
    try {
      // Match Postman: raw JSON body with email / username / password
      final response = await api.post(
        EndPoints.userLogin,
        data: {
          'email': email,
          'username': email, // API often expects username; we pass email there
          'password': password,
        },
        options: Options(contentType: Headers.jsonContentType),
      );

      final loginResponse = LoginResponse.fromJson(
        response.data is Map<String, dynamic>
            ? response.data as Map<String, dynamic>
            : {},
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', loginResponse.token);
      await prefs.setString('user_email', loginResponse.email);
      await prefs.setString('user_name', loginResponse.name);

      api.setTokenIntoHeaderAfterLogin(loginResponse.token);

      return Right(loginResponse);
    } on DioException catch (e) {
      return Left(Failure.fromDioException(e));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}