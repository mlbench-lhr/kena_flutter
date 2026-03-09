import 'package:kena/app/view/app.dart';
import 'package:kena/bootstrap.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap(() => App());
}
