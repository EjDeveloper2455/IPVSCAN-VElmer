import 'package:desing_ipscamv2/login_screen.dart';
import 'package:desing_ipscamv2/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme/color_schemes.g.dart';

class PantallaCargando extends StatefulWidget {
  @override
  State<PantallaCargando> createState() => cargandoState();
}

class cargandoState extends State<PantallaCargando> {
  late AnimationController controller_animation;

  @override
  void initState() {
    /*super.initState();
    controller_animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();*/
    WidgetsBinding.instance.addPostFrameCallback((_) => cambiarPantalla());
  }

  Future<void> cambiarPantalla() async {
    bool? verificar = await verificarCredenciales();
    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                verificar == true ? HomePage() : const LoginScreen()));
  }

  Future<bool?> verificarCredenciales() async {
    String? credentialCache = await getFromCache('token');
    if (credentialCache != null && !credentialCache.isEmpty) return true;
    return false;
  }

// Recuperar datos en caché
  Future<String?> getFromCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString(key));
    return prefs.getString(key);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      title: 'Inicio',
      home: Scaffold(
          body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/loading.png',
              width: 70,
              height: 70,
              color: Colors.black,
            ),
            const Text("Conectando con el servidor...")
          ],
        ),
      )),
    );
  }
}
