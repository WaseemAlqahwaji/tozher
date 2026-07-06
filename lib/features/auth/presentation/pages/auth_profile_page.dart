import 'package:flutter/widgets.dart';

class AuthProfilePage extends StatefulWidget {
  const AuthProfilePage({super.key});

  @override
  State<AuthProfilePage> createState() => _AuthProfilePageState();
}

class _AuthProfilePageState extends State<AuthProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Profile Page'));
  }
}