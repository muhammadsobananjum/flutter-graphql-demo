import 'package:flutter/material.dart';

import 'package:graphqldemo/providers/book_provider.dart';
import 'package:graphqldemo/screens/book_screen.dart';
import 'package:provider/provider.dart';

import 'env/app_env.dart';

void main() {

  debugPrint('===================================================================================');
  debugPrint('====>> Running on ${AppEnv().graphQLApiUrl}');
  debugPrint('===================================================================================');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => BookProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graph QL Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BookScreen(),
    );
  }
}
