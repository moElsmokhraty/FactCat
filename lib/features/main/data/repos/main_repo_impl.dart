import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'main_repo.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/fact_entity.dart';
import '../../../../core/errors/server_failure.dart';
import '../data_sources/main_local_data_source/main_local_data_source.dart';
import '../data_sources/main_remote_data_source/main_remote_data_source.dart';

class MainRepoImpl implements MainRepo {
  final MainRemoteDataSource remoteDataSource;
  final MainLocalDataSource localDataSource;

  MainRepoImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, FactEntity>> getRandomFact() async {
    try {
      final remoteFact = await remoteDataSource.fetchRandomFact();
      return right(remoteFact);
    } on DioException catch (e) {
      final localFact = localDataSource.getRandomFact();
      if (localFact != null) {
        return right(localFact);
      }
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      final localFact = localDataSource.getRandomFact();
      if (localFact != null) {
        return right(localFact);
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
