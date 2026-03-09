import 'package:flutter/material.dart';
import 'package:kena/app/components/my_scaffold.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(body: Center(child: Text("Insights")));
  }
}
