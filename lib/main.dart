import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomsalse/states/authen.dart';
import 'package:roomsalse/states/buyer_main_home.dart';
import 'package:roomsalse/states/seller_main_home.dart';
import 'package:roomsalse/utility/app_controller.dart';
import 'package:roomsalse/utility/app_service.dart';

var getPages = <GetPage<dynamic>>[
  GetPage(
    name: '/authen',
    page: () => const Authen(),
  ),
  GetPage(
    name: '/Buyer',
    page: () => const BuyerMainHome(),
  ),
  GetPage(
    name: '/Seller',
    page: () => const SellerMainHome(),
  ),
];

String? initialPage;

Future<void> main() async {
  AppController appController = Get.put(AppController());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event != null) {
        AppService().findUserModelLogin().then((value) {
          initialPage = '/${appController.loginUserModels.last.typeUser}';
          runApp(const MyApp());
        });
      } else {
        initialPage = '/authen';
        runApp(const MyApp());
      }
    });
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(useMaterial3: true),
      getPages: getPages,
      initialRoute: initialPage,
    );
  }
}
