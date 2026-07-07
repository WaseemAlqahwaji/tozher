import 'package:flutter/material.dart';
import 'package:tozher/generated/l10n.dart';

class AuthCompleteProfilePage extends StatefulWidget {
  const AuthCompleteProfilePage({super.key});

  @override
  State<AuthCompleteProfilePage> createState() => _AuthCompleteProfilePageState();
}

class _AuthCompleteProfilePageState extends State<AuthCompleteProfilePage> {
  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text('Complete your profile'),
          ),
        ],
      ),
    );
  }
}