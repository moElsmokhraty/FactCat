part of 'main_notifier.dart';

abstract class MainState {}

class MainInitial extends MainState {}

class GetRandomFactLoading extends MainState {}

class GetRandomFactSuccess extends MainState {
  final FactEntity fact;

  GetRandomFactSuccess(this.fact);
}

class GetRandomFactFailure extends MainState {
  final String message;

  GetRandomFactFailure(this.message);
}
