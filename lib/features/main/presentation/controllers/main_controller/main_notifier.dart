import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/models/fact_parameter.dart';
import '../../../domain/usecases/get_cat_image_use_case.dart';
import '../../../domain/usecases/get_random_fact_usecase.dart';
import 'main_state.dart';

class MainNotifier extends StateNotifier<MainState> {
  final GetRandomFactUseCase _getRandomFactUseCase;
  final GetCatImageUseCase _getCatImageUseCase;

  MainNotifier(this._getRandomFactUseCase, this._getCatImageUseCase)
    : super(MainState.initial());

  Future<FactParameter?> fetchCombinedFact() async {
    state = state.copyWith(
      factState: GetRandomFactLoading(),
      imageState: GetCatImageLoading(),
    );

    final factResult = await _getRandomFactUseCase.call();
    final imageResult = await _getCatImageUseCase.call();

    if (factResult.isLeft() || imageResult.isLeft()) {
      final factFailure = factResult.fold((l) => l.errMessage, (_) => null);
      final imageFailure = imageResult.fold((l) => l.errMessage, (_) => null);

      if (factFailure != null) {
        state = state.copyWith(factState: GetRandomFactFailure(factFailure));
      }
      if (imageFailure != null) {
        state = state.copyWith(imageState: GetCatImageFailure(imageFailure));
      }
      return null;
    }

    final factEntity = factResult.getOrElse(() => throw UnimplementedError());
    final imagePath = imageResult.getOrElse(() => throw UnimplementedError());

    final fact = FactParameter(fact: factEntity.fact, image: imagePath);

    state = state.copyWith(
      factState: GetRandomFactSuccess(factEntity),
      imageState: GetCatImageSuccess(imagePath),
      factHistory: [...state.factHistory, fact],
    );

    return fact;
  }
}
