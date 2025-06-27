import 'package:flutter/material.dart';
import 'package:toda_app/service/app_theme_data.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          titleTextStyle: AppThemeData.appThemeData.textTheme.labelMedium,
        ),
        body: const Placeholder());
  }
}
