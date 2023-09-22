import 'package:desing_ipscamv2/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';

void main() => runApp(const historial());

class historial extends StatelessWidget {
  const historial({super.key});

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
        body: const Center(
          child: Text('Historial'),
        ),
      ),
    );
  }
}
