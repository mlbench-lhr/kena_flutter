import 'package:flutter/material.dart';
import 'package:kena/app/utils/extensions/context_extensions.dart';

class RecuriterHome extends StatefulWidget {
  const RecuriterHome({super.key});

  @override
  State<RecuriterHome> createState() => _RecuriterHomeState();
}

class _RecuriterHomeState extends State<RecuriterHome> {
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
