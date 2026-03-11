// dependency_injection.dart
// a
// import 'package:get_it/get_it.dart';
// import 'package:ticin/core/networking/dio_helper.dart';
// import 'package:ticin/repo/Auth_repo.dart';
// import 'package:ticin/repo/car_repo.dart';
// import 'package:ticin/repo/stays_repo.dart';

// final getIt = GetIt.instance;

// void setupServiceLocator() {
//   // DioClient
//   getIt.registerLazySingleton<DioClient>(() => DioClient());

//   // AuthRepository
//   getIt.registerLazySingleton<AuthRepository>(
//     () => AuthRepository(getIt<DioClient>()),
//   );
  
//   // StaysRepository
//   getIt.registerLazySingleton<StaysRepository>(
//     () => StaysRepository(getIt<DioClient>()),
//   );
//     getIt.registerLazySingleton<CarRepository>(
//     () => CarRepository(getIt<DioClient>()),
//   );
// }