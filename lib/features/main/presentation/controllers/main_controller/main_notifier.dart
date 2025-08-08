import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/get_cat_image_use_case.dart';
import '../../../domain/usecases/get_random_fact_usecase.dart';
import 'main_state.dart';

class MainNotifier extends StateNotifier<MainState> {
  final GetRandomFactUseCase _getRandomFactUseCase;
  final GetCatImageUseCase _getCatImageUseCase;

  MainNotifier(this._getRandomFactUseCase, this._getCatImageUseCase)
    : super(MainState.initial());

  Future<void> fetchRandomFact() async {
    state = state.copyWith(factState: GetRandomFactLoading());
    final result = await _getRandomFactUseCase.call();
    result.fold(
      (failure) => state = state.copyWith(
        factState: GetRandomFactFailure(failure.errMessage),
      ),
      (fact) => state = state.copyWith(factState: GetRandomFactSuccess(fact)),
    );
  }

  Future<void> fetchCatImage() async {
    state = state.copyWith(imageState: GetCatImageLoading());
    final result = await _getCatImageUseCase.call();
    result.fold(
      (failure) {
        return state = state.copyWith(
        imageState: GetCatImageFailure(failure.errMessage),
      );
      },
      (image) => state = state.copyWith(imageState: GetCatImageSuccess(image)),
    );
  }
}
