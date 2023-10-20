import 'package:desing_ipscamv2/cargando.dart';
import 'package:flutter/material.dart';
import 'theme/color_schemes.g.dart';
import 'package:flutter/services.dart';
import 'inicio.dart';
import 'historial.dart';
import 'ajustes.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      title: 'Principal',
      home: PantallaCargando(),
    ),
  );
}

class HomePage extends StatefulWidget {
  late final BuildContext context2;
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var currentIndex = 0; // Índice de la página actual

  List<Widget> pages = [
    inicio(),
    historial(),
    ajustes(),
  ];

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.history_rounded,
    Icons.settings_rounded,
  ];

  List<String> listOfStrings = [
    'Inicio',
    'Historial',
    'Ajustes',
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkModeEnabled = Theme.of(context).brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Theme.of(context).colorScheme.background,
        //systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness:
            isDarkModeEnabled ? Brightness.light : Brightness.dark,
      ),
    );
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(displayWidth * .05),
        height: displayWidth * .155,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              color:
                  Theme.of(context).colorScheme.inverseSurface.withOpacity(.2),
              blurRadius: 10,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int index = 0; index < 3; index++)
              InkWell(
                onTap: () {
                  setState(() {
                    currentIndex =
                        index; // Actualiza el índice de la página actual
                    HapticFeedback.lightImpact();
                  });
                },
                //splashColor: Colors.transparent,
                //highlightColor: Colors.transparent,
                child: Stack(
                  children: [
                    // Fondo animado de los íconos
                    AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width: index == currentIndex
                          ? displayWidth * .32
                          : displayWidth * .18,
                      alignment: Alignment.center,
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        height: index == currentIndex ? displayWidth * .12 : 0,
                        width: index == currentIndex ? displayWidth * .32 : 0,
                        decoration: BoxDecoration(
                          color: index == currentIndex
                              ? Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(.15)
                              : Colors.transparent,
                          /*
                          color: index == currentIndex
                              ? Colors.blueAccent.withOpacity(.2)
                              : Colors.transparent,
                           */
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    // Contenido animado de los íconos y etiquetas
                    AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width: index == currentIndex
                          ? displayWidth * .31
                          : displayWidth * .18,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          // Animación del espacio previo al ícono y etiqueta
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == currentIndex
                                    ? displayWidth * .13
                                    : 0,
                              ),
                              // Etiqueta animada
                              AnimatedOpacity(
                                opacity: index == currentIndex ? 1 : 0,
                                duration: Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: Text(
                                  index == currentIndex
                                      ? '${listOfStrings[index]}' // Muestra el nombre de la página actual
                                      : '',
                                  style: TextStyle(
                                    //color: Colors.blueAccent,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Ícono animado
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == currentIndex
                                    ? displayWidth * .03
                                    : 20,
                              ),
                              Icon(
                                listOfIcons[index],
                                size: displayWidth * .076,
                                /*color: index == currentIndex
                                    ? Colors.blueAccent // Color activo
                                    : Colors.black26, // Color inactivo
                                 */

                                color: index == currentIndex
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primary // Color activo
                                    : Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer
                                        .withOpacity(0.7), // Color inactivo
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      body: pages[currentIndex], // Cuerpo de la página actual
    );
  }
}
