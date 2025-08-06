import 'package:flutter/material.dart';
import 'widgets/main_view_body.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: MainViewBody()));
  }
}
