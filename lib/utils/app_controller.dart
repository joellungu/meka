import 'package:get/get.dart';
import 'package:meka/utils/requete.dart';

class AppController extends GetxController {
  //
  //
  RxList filtre = [].obs;
  //
  RxList commandes = RxList();
  //
  RxList filtreFavorit = [].obs;
  //
  //
  Requete requete = Requete();
  //
  Future<List> localiser() async {
    //
    Response response = await requete.getE("agent/proximite");
    //
    if (response.isOk) {
      return response.body ?? [];
    } else {
      return [];
    }
  }

  //
  Future<String> faireUneCommande(Map e) async {
    //
    Response response = await requete.postE("course/commande", e);
    //
    if (response.isOk) {
      print("1: ${response.statusCode}");
      print("2: ${response.body}");
      //
      return "";
    } else {
      //
      print("3: ${response.statusCode}");
      print("4: ${response.body}");
      return "";
    }
  }
}
