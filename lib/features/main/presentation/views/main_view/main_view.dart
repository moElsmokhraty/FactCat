import 'package:flutter/material.dart';
import 'widgets/main_view_body.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Random Fact',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: SizedBox.shrink(),
        ),
        body: SafeArea(child: MainViewBody()),
      ),
    );
  }
}
