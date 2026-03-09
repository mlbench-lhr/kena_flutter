import 'package:flutter/material.dart';
import 'package:kena/app/components/my_scaffold.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(body: Center(child: Text("Community")));
  }
}
