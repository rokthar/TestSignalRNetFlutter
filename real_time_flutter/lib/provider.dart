import 'package:flutter/material.dart';

class GlobalProvider with ChangeNotifier {
  List<String> listaNombres = [];
  
  Future<void> setListaNombres(List<dynamic>? lista) async{
    listaNombres.add(lista?[0] + " " + lista?[1]);
    // print(lista?[0]);
    notifyListeners();
  }
}