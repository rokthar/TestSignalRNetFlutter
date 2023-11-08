// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_flutter/provider.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:signalr_flutter/signalr_api.dart';
import 'package:signalr_flutter/signalr_flutter.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String signalStatus = 'disconected';
  late SignalR signalR;
  static late HubConnection connection;
  

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  Future<void> initPlatformState() async {

    //Establesco la conexión
    connection = HubConnectionBuilder().withUrl("http://localhost:5150/send-person").build();
    
    //Inicio la conexión
    connection.start();

    //LLamo al metodo del signalr del back
    connection.on("Recivir", (arguments) {
      //Llamo al metodo del provider para actualizar la lista de los nombres enviados 
      context.read<GlobalProvider>().setListaNombres(arguments);
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalProvider watch = context.watch<GlobalProvider>();
    final TextEditingController nameCtrl = TextEditingController();
    final TextEditingController lastnameCtrl = TextEditingController();

    Future<void> sendPerson() async{
      final dio = Dio();
      try {
        await dio.post('http://localhost:5150/api/PersonAPI', data: {
          'Name':nameCtrl.value.text,
          'LastName': lastnameCtrl.value.text
        });
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                hintText: "Nombre"
              ),
            ),
            TextFormField(
              controller: lastnameCtrl,
              decoration: const InputDecoration(
                hintText: "Apellido"
              ),
            ),
            ElevatedButton(
              onPressed: () {
                sendPerson();
              }, 
              child: const Text("Enviar")
            ),
            ElevatedButton(
              onPressed: () {
                _buttonTapped();
              }, 
              child: const Text("Comprobar Conexion")
            ),
            const SizedBox(height: 100,),
            Column(
              children: watch.listaNombres.isNotEmpty ?
                watch.listaNombres.map((e) => 
                  Text(e)
                ).toList()
              :[],
            )
          ],
        ),
      ),
    );
  }

  void _onStatusChange(ConnectionStatus? status) {
    if (mounted) {
      setState(() {
        signalStatus = status?.name ?? ConnectionStatus.disconnected.name;
      });
    }
  }

  void _onNewMessage(String methodName, String message) {
    print("MethodName = $methodName, Message = $message");
  }

  void _buttonTapped() async {
    try {
      final result = await signalR.invokeMethod("Recivir",
          arguments: ["name","lastname"]);
      print(result);
    } catch (e) {
      print(e);
    }
  }

}