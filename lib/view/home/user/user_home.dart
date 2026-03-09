import 'package:flutter/material.dart';
import 'package:kena/app/utils/extensions/context_extensions.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recuriter Home')),
      body: Center(
        child: Text('Recurite Home', style: context.typography.title),
      ),
    );
  }
}
