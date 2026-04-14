import 'package:flutter/material.dart';

import 'presentation/screens/home_screen.dart';

class VietLunarCalendarApp extends StatelessWidget {
  const VietLunarCalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lịch Âm Việt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB45309)),
        scaffoldBackgroundColor: const Color(0xFFFAF7F2),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
