import 'package:flutter/material.dart';
import 'app/app_theme.dart';
import 'pages/portfolio_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const YusufPortfolioApp());
}

class YusufPortfolioApp extends StatelessWidget {
  const YusufPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yusuf Sanjaya | Retro Arcade Portfolio & Space Shooter',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.retroTheme,
      home: const PortfolioShell(),
    );
  }
}
