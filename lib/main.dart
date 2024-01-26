import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hotel/src/presentation/screens/hotel_screen.dart';
import 'package:hotel/src/presentation/screens/pay_success_screen.dart';
import 'package:hotel/src/presentation/screens/reservation_screen.dart';
import 'package:hotel/src/presentation/screens/room_selection_screen.dart';
import 'package:injectable/injectable.dart';
import 'src/di/di.dart';

void main() async {
  getIt.registerSingleton<Dio>(Dio());
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(Environment.dev);
  HttpOverrides.global = MyHttpOverrides();
  runApp(const HotelApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class HotelApp extends StatelessWidget {
  const HotelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel',
      debugShowCheckedModeBanner: false,
      initialRoute: HotelScreen.routeName,
      routes: {
        HotelScreen.routeName: (context) => const HotelScreen(),
        RoomSelectionScreen.routeName: (context) => const RoomSelectionScreen(),
        ReservationScreen.routeName: (context) => const ReservationScreen(),
        PaySuccessScreen.routeName: (context) => const PaySuccessScreen(),
      },
    );
  }
}
