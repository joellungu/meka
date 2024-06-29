import 'package:flutter/material.dart';
import 'package:meka/widgets/commande_attente.dart';

class Demande extends StatefulWidget {
  String photoPath;
  Demande(this.photoPath);
  //
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Demande();
  }
}

class _Demande extends State<Demande> {
  @override
  Widget build(BuildContext context) {
    //
    return Container(
      height: 380,
      width: 350,
      color: Colors.transparent,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              width: 350,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage("assets/pub.jpg"),
                  fit: BoxFit.fill,
                ),
                //color: Colors.blue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                //color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(100),
              ),
              child: CommandeAttente(widget.photoPath),
            ),
          ),
        ],
      ),
    );
  }
}
