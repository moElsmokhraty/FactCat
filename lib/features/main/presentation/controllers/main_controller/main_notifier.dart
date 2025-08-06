import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/fact_entity.dart';
import '../../../domain/usecases/get_random_fact_usecase.dart';

part 'main_state.dart';

class MainNotifier extends StateNotifier<MainState> {
  MainNotifier(this._useCase) : super(MainInitial());

  final GetRandomFactUseCase _useCase;


  Future<void> fetchRandomFact() async {
    state = GetRandomFactLoading();
    final result = await _useCase.call();
    result.fold(
      (failure) => state = GetRandomFactFailure(failure.errMessage),
      (fact) => state = GetRandomFactSuccess(fact),
    );
  }
}
