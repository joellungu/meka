import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meka/firebase_options.dart';
import 'package:meka/pages/accueil.dart';
import 'package:meka/utils/local_notification_service.dart';

import 'pages/carte.dart';
import 'utils/app_controller.dart';

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  //
  await GetStorage.init();
  //
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //
  // Set the background messaging handler early on, as a named top-level function
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //
  try {
    var box = GetStorage();
    //
    FirebaseMessaging.instance.requestPermission();
    String? token = await FirebaseMessaging.instance.getToken();
    //
    box.write("token", token);
    //
    print("token: $token");
    //
  } catch (e) {
    print("erreur: $e");
  }
  //

  //
  if (!kIsWeb) {
    //NotificationController.initialiserLeBack();
    LocalNotificationService.initialize();
    //await setupFlutterNotifications();
  }
  //
  AppController appController = Get.put(AppController());
  //
  runApp(const Meka());
}

class Meka extends StatelessWidget {
  const Meka({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Meka',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Accueil(),
    );
  }
}
