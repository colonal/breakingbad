import 'package:flutter/material.dart';

import 'app_router.dart';

void main() {
  runApp(BreakingbadApp(
    appRouter: AppRouter(),
  ));
}

class BreakingbadApp extends StatelessWidget {
  const BreakingbadApp({required this.appRouter, Key? key}) : super(key: key);
  final AppRouter? appRouter;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter!.generateRoute,
    );
  }
}
