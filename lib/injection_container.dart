import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:vzadi/features/map/data/data_sources/map_remote_data_source.dart';
import 'package:vzadi/features/map/data/repositories/map_repository_impl.dart';
import 'package:vzadi/features/map/domain/repositories/map_repository.dart';
import 'package:vzadi/features/map/presentation/cubit/map_cubit.dart';
import 'core/api/api_consumer.dart';
import 'core/api/app_interceptors.dart';
import 'core/api/dio_consumer.dart';
import 'core/network/network_info.dart';
import 'features/map/domain/use_cases/final_destination_use_case.dart';
import 'features/map/domain/use_cases/get_directions_use_case.dart';
import 'features/map/domain/use_cases/places_suggestion_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async{
  /// features
  /// blocs
  sl.registerFactory(() => MapCubit(placesSuggestionsUseCase:sl(),getDirectionsUseCase: sl(),finalDestinationUseCase: sl()));
///usecases
  sl.registerLazySingleton<PlacesSuggestionsUseCase>(() => PlacesSuggestionsUseCase(mapRepository: sl()));
  sl.registerLazySingleton<FinalDestinationUseCase>(() => FinalDestinationUseCase(mapRepository: sl()));
  sl.registerLazySingleton<GetDirectionsUseCase>(() => GetDirectionsUseCase(mapRepository: sl()));

  ///repositories
  sl.registerLazySingleton<MapRepository>(() => MapRepositoryImpl(
      mapRemoteDataSource: sl())
  );

  ///remote dataSource
  sl.registerLazySingleton<MapRemoteDataSource>(() => MapRemoteDataSourceImpl(apiConsumer:sl()));

  ///core
  sl.registerLazySingleton<NetWorkInfo>(() => NetWorkInfoImpl(internetConnectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));


  ///external
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
    request: true,
    requestBody: true,
    requestHeader: true,
    responseBody: true,
    responseHeader: true,
    error: true,
  ));


}
