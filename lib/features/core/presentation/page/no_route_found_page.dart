import 'package:flutter/material.dart';

class NoRouteFoundPage extends StatelessWidget {
  const NoRouteFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('No Route Found')),
      body: const Center(
        child: Text('The page you are looking for does not exist.'),
      ),
    );
  }
}
