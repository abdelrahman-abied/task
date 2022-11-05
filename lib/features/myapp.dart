import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/constants.dart';
import '../core/router/app_routing.dart';
import 'login/presentation/pages/login_page.dart';
import 'login/presentation/provider/login_provider.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      ref.read(userLoginProvider).checkUsertatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final router = ref.watch(routerProvider);
        return MaterialApp.router(
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          title: 'Flutter Coding Challenge',
          darkTheme: ThemeData.light(),
          themeMode: ThemeMode.light,

          // home: isLogged ? LoginPage() : UserPage(),
        );
      },
    );
  }
}
