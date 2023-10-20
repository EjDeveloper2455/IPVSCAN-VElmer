import 'package:desing_ipscamv2/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const ajustes());

class ajustes extends StatelessWidget {
  const ajustes({super.key});

  Future<void> saveToCache(String key, String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', data);
  }

  Future<void> deleteToCache(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ajustes',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pantalla de Ajustes'),
        ),
        body: Center(
            child: Container(
          width: double.infinity, // Ocupa todo el ancho disponible
          height: 40,

          decoration: BoxDecoration(),
          margin: const EdgeInsets.fromLTRB(
              35, 25, 35, 35), // Espaciado alrededor del botón
          child: ElevatedButton(
            onPressed: () {
              deleteToCache("token");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20.0), // Bordes redondeados
                ),
                backgroundColor: Color.fromRGBO(1, 72, 179, 1)),
            child: const Text(
              'Cerrar sesion',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
        )),
      ),
    );
  }
}
