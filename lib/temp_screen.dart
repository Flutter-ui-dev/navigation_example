import 'package:flutter/material.dart';

class TempScreen extends StatelessWidget {
  const TempScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Temp Screen"),
      ),
      body: const Center(
        child: Text("You Click on Temp Screen"),
      ),
    );
  }
}
