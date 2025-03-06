import 'package:flutter/material.dart';
import 'package:hotel_booking/app/app.dart';
import 'package:hotel_booking/app/di/di.dart';
import 'package:hotel_booking/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService().init();

  await initDependencies();
  runApp(const MyApp());
}
