import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:meka/utils/requete.dart';

class Carte extends StatefulWidget {
  static const String route = '/';

  List agents = [];
  Position position;

  Carte(this.agents, this.position, {super.key});

  @override
  State<Carte> createState() => _Carte();
}

class _Carte extends State<Carte> {
  //
  //
  final mapController = MapController();
  //
  @override
  void initState() {
    super.initState();
    //showIntroDialogIfNeeded();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: () {
              //
            },
            icon: const Icon(
              Icons.location_searching,
              color: Colors.black,
            ),
          )
        ],
      ),
      //drawer: const MenuDrawer(HomePage.route),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
                crs: const Epsg3857(),
                //cameraConstraint: CameraConstraint.containCenter(bounds: bounds),
                backgroundColor: Colors.black,
                initialCenter:
                    LatLng(widget.position.latitude, widget.position.longitude),
                initialZoom: 17,
                maxZoom: 18,
                minZoom: 16
                // cameraConstraint: CameraConstraint.contain(
                //   bounds: LatLngBounds(
                //     const LatLng(-4.44031,15.25955),
                //     const LatLng(47, 180),
                //   ),
                // ),
                ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                //userAgentPackageName: 'com.mekaapp.mekaapp',
                // Use the recommended flutter_map_cancellable_tile_provider package to
                // support the cancellation of loading tiles.
                //tileProvider: CancellableNetworkTileProvider(),
                tileBuilder: (BuildContext context, Widget tileWidget, tile) {
                  //
                  const ColorFilter greyscale = ColorFilter.matrix(<double>[
                    0.2126,
                    0.7152,
                    0.0722,
                    0,
                    0,
                    0.2126,
                    0.7152,
                    0.0722,
                    0,
                    0,
                    0.2126,
                    0.7152,
                    0.0722,
                    0,
                    0,
                    0,
                    0,
                    0,
                    1,
                    0,
                  ]);
                  /*
                  -0.2126, -0.7152, -0.0722, 0, 255, // Red channel
                  -0.2126, -0.7152, -0.0722, 0, 255, // Green channel
                  -0.2126, -0.7152, -0.0722, 0, 255, // Blue channel
                  0,       0,       0,       1, 0,   // Alpha channel
                   */
                  //return greyscale;
                  //
                  return ColorFiltered(
                      colorFilter: const ColorFilter.matrix(<double>[
                        -0.2126, -0.7152, -0.0722, 0, 255, // Red channel
                        -0.2126, -0.7152, -0.0722, 0, 255, // Green channel
                        -0.2126, -0.7152, -0.0722, 0, 255, // Blue channel
                        0, 0, 0, 1, 0, // Alpha channel
                      ]),
                      child: tileWidget);
                },
              ),
              //
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(
                        widget.position.latitude, widget.position.longitude),
                    height: 50,
                    width: 100,
                    child: InkWell(
                      onTap: () {
                        /*
                            Get.to(
                              Details(
                                {"profil": agent["profil"]},
                              ),
                            );
                            */
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              //margin: const EdgeInsets.only(left: 10),
                              height: 35,
                              width: 35,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                // image: const DecorationImage(
                                //   image: ExactAssetImage(
                                //     "assets/maq4-removebg-preview.png",
                                //   ),
                                //   fit: BoxFit.contain,
                                // ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(17.5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.blue,
                                    blurRadius: 2.5,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Colors.black,
                              )

                              // child: const Icon(
                              //   CupertinoIcons.person,
                              //   size: 35,
                              //   color: Colors.black,
                              // ),
                              ),
                          Text(
                            "Vous",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ]..addAll(
                    List.generate(
                      widget.agents.length,
                      (index) {
                        Map agent = widget.agents[index];
                        return Marker(
                          point: LatLng(agent["latitude"], agent["longitude"]),
                          height: 50,
                          width: 100,
                          child: InkWell(
                            onTap: () {
                              /*
                            Get.to(
                              Details(
                                {"profil": agent["profil"]},
                              ),
                            );
                            */
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Hero(
                                  tag: "assets/${agent["profil"]}",
                                  child: Container(
                                    //margin: const EdgeInsets.only(left: 10),
                                    height: 35,
                                    width: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          "${Requete.url}/agent/profil.png?telephone=${agent['telephone']}",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(17.5),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.blue,
                                          blurRadius: 2.5,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    // child: Image.network(
                                    //     "${Requete.url}/agent/profil.png?telephone=${agent['telephone']}",
                                    //   ),
                                  ),

                                  // child: const Icon(
                                  //   CupertinoIcons.person,
                                  //   size: 35,
                                  //   color: Colors.black,
                                  // ),
                                ),
                                Text(
                                  "${agent["nom"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ),
              // const RichAttributionWidget(
              //   popupInitialDisplayDuration: Duration(seconds: 5),
              //   animationConfig: ScaleRAWA(),
              //   showFlutterMapAttribution: false,
              //   attributions: [
              //     // TextSourceAttribution(
              //     //   'OpenStreetMap contributors',
              //     //   onTap: () async => launchUrl(
              //     //     Uri.parse('https://openstreetmap.org/copyright'),
              //     //   ),
              //     // ),
              //     TextSourceAttribution(
              //       'This attribution is the same throughout this app, except '
              //       'where otherwise specified',
              //       prependCopyright: false,
              //     ),
              //   ],
              // ),
            ],
          ),
          //const FloatingMenuButton()
        ],
      ),
    );
  }

  //
}
