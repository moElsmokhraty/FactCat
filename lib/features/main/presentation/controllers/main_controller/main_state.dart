import '../../../domain/entities/fact_entity.dart';

sealed class FactState {}

class FactInitial extends FactState {}

class GetRandomFactLoading extends FactState {}

class GetRandomFactSuccess extends FactState {
  final FactEntity fact;
  GetRandomFactSuccess(this.fact);
}

class GetRandomFactFailure extends FactState {
  final String message;
  GetRandomFactFailure(this.message);
}

sealed class ImageState {}

class ImageInitial extends ImageState {}

class GetCatImageLoading extends ImageState {}

class GetCatImageSuccess extends ImageState {
  final String image;
  GetCatImageSuccess(this.image);
}

class GetCatImageFailure extends ImageState {
  final String message;
  GetCatImageFailure(this.message);
}

class MainState {
  final FactState factState;
  final ImageState imageState;

  MainState({
    required this.factState,
    required this.imageState,
  });

  MainState copyWith({
    FactState? factState,
    ImageState? imageState,
  }) {
    return MainState(
      factState: factState ?? this.factState,
      imageState: imageState ?? this.imageState,
    );
  }

  factory MainState.initial() => MainState(
    factState: FactInitial(),
    imageState: ImageInitial(),
  );
}
