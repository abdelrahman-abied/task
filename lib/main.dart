import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/utils/cache_helper.dart';
import '../features/myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  // CacheHelper.clearAll();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
