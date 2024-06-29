import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:meka/pages/carte.dart';
import 'package:meka/utils/app_controller.dart';
import 'package:meka/utils/position.dart';
import 'package:meka/widgets/loader.dart';

import 'catalogue.dart';

class Accueil extends StatelessWidget {
  //
  AppController appController = Get.find();
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Meka",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              //

              //
            },
            icon: const Icon(Icons.grid_4x4),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Catalogue(),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 50,
              width: 250,
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                onPressed: () async {
                  //
                  Loader.load();
                  //
                  Position p = await MaPosition.determinePosition();
                  //
                  List agents = await appController.localiser();
                  //
                  Get.back();
                  //
                  print("agents: $agents");
                  if (agents.isNotEmpty) {
                    Get.to(Carte(agents, p));
                  } else {
                    Get.to(Carte(agents, p));
                    // Get.dialog(
                    //   const Center(
                    //     child: Text("Oups pas d'agents à proximité !"),
                    //   ),
                    // );
                  }
                },
                child: const Text(
                  "Commander",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  //
}
