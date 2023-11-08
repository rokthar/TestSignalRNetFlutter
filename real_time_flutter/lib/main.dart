import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_flutter/home.dart';
import 'package:real_time_flutter/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<GlobalProvider>(create: (_) => GlobalProvider()),],
      builder: (context, _) {
        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: HomePage()
            ),
          ),
        );
      },
    );
  }
}
