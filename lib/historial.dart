import 'package:desing_ipscamv2/cod_utils/HttpGetRequest.dart';
import 'package:desing_ipscamv2/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class historial extends StatefulWidget {
  historial({super.key});

  @override
  State<historial> createState() => _historialState();
}

class _historialState extends State<historial> {
  List _listarRegistro = [Registro("MAT1234", "08-09-2023 12:00:00")];
  @override
  void initState() {
    super.initState();
    getRequest();
  }

  Future<void> getRequest() async {
    HttpGetRequest httpRequest = HttpGetRequest();
    String url = 'http://34.125.252.26:8080/api/registro/1';
    String? result = await httpRequest.fetchUrl(url);
    if (result == null || result.isEmpty) {
    } else {
      analizar_jSon(result);
    }
  }

  void analizar_jSon(String result) {
    try {
      //Map<String, dynamic> apexObject = json.decode(result);
      List<dynamic> apexItems = json.decode(result);

      if (apexItems.isNotEmpty) {
        setState(() {
          apexItems.forEach((jsonData) {
            _listarRegistro.add(Registro(jsonData["placa"], jsonData["fecha"]));
          });
        });

        /*setState(() {
          
        });*/
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      title: 'Historial',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Pantalla de Historial'),
          ),
          body: ListView.builder(
              itemCount: _listarRegistro.length,
              itemBuilder: (BuildContext context, int index) {
                final log = _listarRegistro[index];
                return Container(
                    margin: const EdgeInsets.all(
                        4.0), // Espacio alrededor del ListTile

                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 253, 253, 253),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.5), // Color de la sombra
                          spreadRadius: 5, // Radio de expansión de la sombra
                          blurRadius: 8, // Radio de desenfoque de la sombra
                          offset: const Offset(0,
                              3), // Desplazamiento de la sombra (horizontal, vertical)
                        ),
                      ],
                      borderRadius:
                          BorderRadius.circular(15.0), // Bordes redondeados
                      border: Border.all(
                        color: Colors.blue, // Color del borde
                        width: 2.0, // Ancho del borde
                      ),
                    ),
                    child: ListTile(
                      title: Text(log.placa),
                      subtitle: Text(log.fecha),
                      leading: Image.asset(
                        'assets/images/historial1.png',
                        width: 50,
                        height: 50,
                      ),
                      trailing: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                              255, 0, 0, 0), // Color de fondo del Container
                          borderRadius:
                              BorderRadius.circular(20.0), // Bordes redondeados
                        ),
                        child: IconButton(
                          onPressed: () async {},
                          icon: const Icon(
                            Icons.search,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                      //onLongPress: () => _mostrarAlerta(context, log.placa),
                    ));
              })),
    );
  }
}

class Registro {
  late String placa;
  late String fecha;

  Registro(this.placa, this.fecha);
}
