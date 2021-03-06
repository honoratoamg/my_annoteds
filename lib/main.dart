import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:my_annoteds/app/app_module.dart';
import 'package:my_annoteds/app/repositories/local/LocalNotification/local_notification.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Stetho.initialize();
  await LocalNotification.initializeSettings();
  runApp(ModularApp(module: AppModule()));
}