import 'package:dartz/dartz.dart';
import '../../../../core/usecases/no_param_usecase.dart';
import '../entities/fact_entity.dart';
import '../../data/repos/main_repo.dart';
import '../../../../core/errors/failure.dart';

class GetRandomFactUseCase extends UseCase<FactEntity> {
  const GetRandomFactUseCase(this._mainRepo);

  final MainRepo _mainRepo;

  @override
  Future<Either<Failure, FactEntity>> call() async {
    return await _mainRepo.getRandomFact();
  }
}
