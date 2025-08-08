import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/di/service_locator.dart';
import '../../../../domain/usecases/get_cat_image_use_case.dart';
import '../../../../domain/usecases/get_random_fact_usecase.dart';
import '../../../controllers/main_controller/main_notifier.dart';
import '../../../controllers/main_controller/main_state.dart';

final getRandomFactUseCaseProvider = Provider<GetRandomFactUseCase>((ref) {
  return getIt<GetRandomFactUseCase>();
});

final getCatImageUseCaseProvider = Provider<GetCatImageUseCase>((ref) {
  return getIt<GetCatImageUseCase>();
});

final mainNotifierProvider =
    StateNotifierProvider.autoDispose<MainNotifier, MainState>((ref) {
      return MainNotifier(
        ref.watch(getRandomFactUseCaseProvider),
        ref.watch(getCatImageUseCaseProvider),
      );
    });

class MainViewBody extends ConsumerStatefulWidget {
  const MainViewBody({super.key});

  @override
  ConsumerState<MainViewBody> createState() => _MainViewBodyState();
}

class _MainViewBodyState extends ConsumerState<MainViewBody> {
  bool _isFirstLoadDone = false;

  @override
  void initState() {
    super.initState();
    _loadInitialContent();
  }

  Future<void> _loadInitialContent() async {
    Future.microtask(() async {
      final notifier = ref.read(mainNotifierProvider.notifier);
      await Future.wait([notifier.fetchRandomFact(), notifier.fetchCatImage()]);
      if (mounted) {
        setState(() => _isFirstLoadDone = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mainNotifierProvider);

    return _isFirstLoadDone
        ? Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildImageStateContent(state.imageState),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final notifier = ref.read(mainNotifierProvider.notifier);
                    await Future.wait([
                      notifier.fetchRandomFact(),
                      notifier.fetchCatImage(),
                    ]);
                  },
                  child: const Text(
                    'Another Fact!',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                Center(child: _buildFactStateContent(state.factState)),
              ],
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }

  Widget _buildFactStateContent(FactState state) {
    return switch (state) {
      GetRandomFactLoading() => const CircularProgressIndicator(),
      GetRandomFactFailure(:final message) => Text(
        'Error: $message',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      GetRandomFactSuccess(:final fact) => Text(
        fact.fact,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _buildImageStateContent(ImageState state) {
    return switch (state) {
      GetCatImageLoading() => Container(
        alignment: Alignment.center,
        height: 250,
        width: 500,
        child: const CircularProgressIndicator(),
      ),
      GetCatImageFailure(:final message) => Text(
        'Error: $message',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      GetCatImageSuccess(:final image) =>
        image.startsWith('http')
            ? Image.network(image, height: 250, width: 500, fit: BoxFit.cover)
            : Image.file(
                File(image),
                height: 250,
                width: 500,
                fit: BoxFit.cover,
              ),
      _ => const SizedBox.shrink(),
    };
  }
}
