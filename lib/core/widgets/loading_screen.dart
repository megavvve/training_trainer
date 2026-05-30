import 'package:flutter/material.dart';
import 'package:training_trainer/uikit/loaders/page_loader.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PageLoader(),
    );
  }
}
