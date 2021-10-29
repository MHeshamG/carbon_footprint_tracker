import 'package:carbon_footprint_tracker/core/AuthenticationService.dart';
import 'package:carbon_footprint_tracker/firebase/FirebaseAuthenticationService.dart';
import 'package:carbon_footprint_tracker/firebase/FirebaseCarbonRepository.dart';
import 'package:carbon_footprint_tracker/repository/repository_impl/PointsRepositoryImpl.dart';
import 'package:carbon_footprint_tracker/repository/CarbonRepository.dart';
import 'package:carbon_footprint_tracker/repository/PointsRepository.dart';
import 'package:carbon_footprint_tracker/viewmodel/TodayCarbonEmissionViewModel.dart';
import 'package:carbon_footprint_tracker/viewmodel/LoginViewModel.dart';
import 'package:carbon_footprint_tracker/viewmodel/MonthlyCarbonViewModel.dart';
import 'package:carbon_footprint_tracker/viewmodel/PointsViewModel.dart';
import 'package:carbon_footprint_tracker/viewmodel/SignUpPageViewModel.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<CarbonRepository>(
      () => FirebaseCarbonRepository());
  getIt.registerLazySingleton<AuthenticationService>(
      () => FirebaseAuthenticationService());
  getIt.registerFactory(() => TodayCarbonEmissionViewModel());
  getIt.registerFactory(() => MonthlyCarbonEmissionViewModel());
  getIt.registerFactory(() => LoginViewModel());
  getIt.registerFactory(() => SignUpPageViewModel());
  getIt.registerLazySingleton<PointsRepository>(
      () => PointsRepositoryImpl());
  getIt.registerFactory(() => PointsViewModel());
}
