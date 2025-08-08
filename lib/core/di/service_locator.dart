import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/main/data/data_sources/main_local_data_source/main_local_data_source.dart';
import '../../features/main/data/data_sources/main_local_data_source/main_local_data_source_impl.dart';
import '../../features/main/data/data_sources/main_remote_data_source/main_remote_data_source.dart';
import '../../features/main/data/data_sources/main_remote_data_source/main_remote_data_source_impl.dart';
import '../../features/main/data/repos/main_repo.dart';
import '../../features/main/data/repos/main_repo_impl.dart';
import '../../features/main/domain/usecases/get_cat_image_use_case.dart';
import '../../features/main/domain/usecases/get_random_fact_usecase.dart';
import '../api/api_service.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 120),
      sendTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
      receiveDataWhenStatusError: true,
    ),
  );

  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  getIt.registerSingleton<MainRemoteDataSource>(
    MainRemoteDataSourceImpl(getIt.get<ApiService>()),
  );

  getIt.registerSingleton<MainLocalDataSource>(MainLocalDataSourceImpl());

  getIt.registerSingleton<MainRepo>(
    MainRepoImpl(
      remoteDataSource: getIt.get<MainRemoteDataSource>(),
      localDataSource: getIt.get<MainLocalDataSource>(),
    ),
  );

  getIt.registerSingleton<GetRandomFactUseCase>(
    GetRandomFactUseCase(getIt.get<MainRepo>()),
  );

  getIt.registerSingleton<GetCatImageUseCase>(
    GetCatImageUseCase(getIt.get<MainRepo>()),
  );
}
