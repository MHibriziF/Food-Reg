import 'package:flutter/material.dart';

import 'app.dart';
import 'services/dependencies/di.dart';
import 'services/storage/_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await HiveService.init();
  runApp(const MyApp());
}
