import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:xpenso/hive_registrar.g.dart';

import 'providers/transaction_provider.dart';
import 'ui/screens/center/bottom_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final appDocumentDir = await getApplicationDocumentsDirectory();

    Hive
      ..init(appDocumentDir.path)
      ..registerAdapters();
  } catch (e, stackTrace) {
    log('Failed to initialize Hive: $e', stackTrace: stackTrace);
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => TransactionProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const BottomBar(),
    );
  }
}
