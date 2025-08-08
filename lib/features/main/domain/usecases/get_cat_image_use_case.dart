import 'package:dartz/dartz.dart';
import '../../../../core/usecases/no_param_usecase.dart';
import '../../data/repos/main_repo.dart';
import '../../../../core/errors/failure.dart';

class GetCatImageUseCase extends UseCase<String> {
  const GetCatImageUseCase(this._mainRepo);

  final MainRepo _mainRepo;

  @override
  Future<Either<Failure, String>> call() async {
    return await _mainRepo.getCatImage();
  }
}
