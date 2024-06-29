import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'carte.dart';

class Catalogue extends StatelessWidget {
  //
  List cats = [
    {"type": "Manucure", "icon": "chf0"},
    {"type": "Péducure", "icon": "chf1"},
    {"type": "Coiffure", "icon": "chf3"},
    {"type": "Makeup", "icon": "chf12"},
    {"type": "Plantes", "icon": "chf2"},
    {"type": "Barbier", "icon": "chf10"},
    {"type": "Tresse", "icon": "chf11"},
    {"type": "Mèches", "icon": "chf4"},
    // {"type": "IST Bukko", "icon": "chf5"},
    // {"type": "IST Kima", "icon": "chf6"},
    // {"type": "IST Bukko", "icon": "chf7"},
    // {"type": "IST Kima", "icon": "chf8"},
    // {"type": "IST Kima", "icon": "chf9"},
    // {"titre": "Aide", "icon": "MdiCarPickup"},
    // {"titre": "Profil", "icon": "PhMotorcycleFill"},
  ];

  //
  @override
  Widget build(BuildContext context) {
    //
    return GridView.count(
      padding: EdgeInsets.all(10),
      crossAxisCount: 2,
      childAspectRatio: 0.9,
      mainAxisSpacing: 7,
      crossAxisSpacing: 7,
      children: List.generate(cats.length, (index) {
        //
        Map e = cats[index];
        //
        RxBool c = false.obs;
        //
        return InkWell(
          onTap: () async {
            //
            c.value = !c.value;
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            margin: EdgeInsets.all(1),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Container(
                          decoration: const BoxDecoration(
                            //color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Obx(
                            () => SvgPicture.asset(
                              "assets/${e["icon"]}.svg",
                              color:
                                  c.value ? Colors.teal : Colors.grey.shade300,
                              // colorFilter: ColorFilter.mode(
                              //    Colors.white,
                              //   BlendMode.darken,
                              // ),
                              semanticsLabel: "",
                              height: 100,
                              width: 100,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            //color: Colors.green,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Obx(
                            () => Text(
                              "${e["type"]}",
                              style: TextStyle(
                                color: c.value ? Colors.teal : Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: InkWell(
                      onTap: () async {
                        //
                      },
                      child: Obx(
                        () => Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: c.value ? Colors.teal : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
