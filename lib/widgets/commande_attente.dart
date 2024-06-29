import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meka/utils/app_controller.dart';

class CommandeAttente extends StatefulWidget {
  String photoPath;
  CommandeAttente(this.photoPath, {super.key});

  @override
  State<CommandeAttente> createState() => _CommandeAttente();
}

class _CommandeAttente extends State<CommandeAttente>
    with TickerProviderStateMixin {
  late AnimationController controller;
  AppController appController = Get.find();

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 60),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: false);
    super.initState();
    //
    /**
     * .putData("dest", "agent")
        .putData("but", "commande")
        .putData("title", "Nouvelle commande")
        .putData("tokenUtilisateur", (String) commande.get("tokenUtilisateur"))
        .putData("tokenAgent", (String) commande.get("tokenAgent"))
        .putData("latitudeU", (String) commande.get("latitudeU"))
        .putData("longitudeU", (String) commande.get("longitudeU"))
        .putData("commande", (String) commande.get("commande"))
        .setToken((String) commande.get("tokenAgent"))
     */
    Map e = {
      "dest": "agent",
      "but": "commande",
      "title": "Nouvelle commande",
      "telephoneAgent": "243815381693",
      "tokenUtilisateur":
          """f4QFdUSiR46xYGz5GVcLRB:APA91bGbhJt3zrYbu6RjyMPE8nmXhhaNw8E2JD9crX63czg-JvV5HUvrIBj-djCwAoD8wlbSNUxjZ8jiKwI0hqqgRD7OJ45__ffddUTuKut1yPKxrZZmv72ZXDeC3RAZg1o2vKVWbE7k""",
      "tokenAgent":
          """fz51v8DuRfyKyaYn0kKeUm:APA91bHdupFNHYVI61MdYo1KD0nHoj8MlHs2y1q48FKcgIjPp9tmwx35w7pNRjOMhvGR6Ww0jktZxpGj-LAkZklJr2uYrGaM4DCI-SlAEcjAWDe1X1XizxrqXmUebLbnh1rCv3nvgJf_""",
      "latitudeU": "-4.432162",
      "longitudeU": "15.275577",
      "commande": "Manicure (Femme)",
    };
    //
    appController.faireUneCommande(e);
    //
  }

  //

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        height: 200,
        width: 200,
        //alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: ExactAssetImage(widget.photoPath),
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        //padding: const EdgeInsets.all(20.0),
        child: CircularProgressIndicator(
          value: controller.value,
          strokeWidth: 10,
          color: Colors.blue,
          semanticsLabel: 'Circular progress indicator',
        ),
      ),
    );
  }
}
