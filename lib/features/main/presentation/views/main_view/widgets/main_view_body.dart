import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/di/service_locator.dart';
import '../../../../domain/usecases/get_random_fact_usecase.dart';
import '../../../controllers/main_controller/main_notifier.dart';

final getRandomFactUseCaseProvider = Provider<GetRandomFactUseCase>((ref) {
  return getIt<GetRandomFactUseCase>();
});

final mainProvider = StateNotifierProvider.autoDispose<MainNotifier, MainState>(
  (ref) {
    return MainNotifier(ref.watch(getRandomFactUseCaseProvider));
  },
);

class MainViewBody extends ConsumerWidget {
  const MainViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mainProvider);
    final notifier = ref.read(mainProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Random Fact'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: notifier.fetchRandomFact,
              child: const Text('Get Random Fact'),
            ),
            const SizedBox(height: 20),
            Center(child: _buildStateContent(state)),
          ],
        ),
      ),
    );
  }

  Widget _buildStateContent(MainState state) {
    return switch (state) {
      GetRandomFactLoading() => const CircularProgressIndicator(),
      GetRandomFactFailure(:final message) => Text(
        'Error: $message',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      GetRandomFactSuccess(:final fact) => Text(
        fact.fact,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      _ => const Text(
        'Tap the button to get a random fact',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    };
  }
}
