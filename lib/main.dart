import 'dart:async';

import 'package:binance_demo/presentation/views/home_view.dart';
import 'package:binance_demo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: constant_identifier_names

void main() async {
  // final _logger = appLogger(Main as Type);
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      runApp(const ProviderScope(child: MyApp()));
    },
    (error, stackTrace) => print(
      error.toString(),
      // stackTrace: stackTrace,
      // functionName: "main",
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Binance-Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}
