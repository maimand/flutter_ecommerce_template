import 'package:ecommerce_int2/data/provider/auth.provider.dart';
import 'package:ecommerce_int2/data/repository/auth.repository.dart';
import 'package:ecommerce_int2/screens/splash_page.dart';
import 'package:ecommerce_int2/services/auth.service.dart';
import 'package:ecommerce_int2/services/network.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  initDependencies();
  runApp(MyApp());
}

void initDependencies() {
  Get
    ..put(NetWorkService(Get.find<AuthService>()))
    ..put(AuthProvider(Get.find<NetWorkService>()))
    ..put(AuthRepository(Get.find<AuthProvider>()))
    ..put<AuthService>(AuthService(Get.find<AuthRepository>()))
    ;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'eCommerce int2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        canvasColor: Colors.transparent,
        primarySwatch: Colors.blue,
        fontFamily: "Montserrat",
      ),
      home: SplashScreen(),
    );
  }
}
