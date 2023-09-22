import 'package:desing_ipscamv2/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ajustes());

class ajustes extends StatelessWidget {
  const ajustes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      title: 'Ajustes',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pantalla de Ajustes'),
        ),
        body: const Center(
          child: Text('Ajustes'),
        ),
      ),
    );
  }
}
