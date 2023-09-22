import 'package:flutter/material.dart';
import '../theme/color_schemes.g.dart';


class ContenidoConsulta extends StatelessWidget {
  final Map<String, dynamic> json;
  const ContenidoConsulta({super.key, required this.json});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      title: 'Contenido',
      home: Scaffold(
        body: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                //color: Color.fromARGB(255, 4, 46, 73),
                color:Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 30, // Añade margen superior
                    left: 125,
                    child: Container(
                      width: 150,
                      height: 100,
                      child: ClipRect(
                        child: Container(
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                    //color:Theme.of(context).colorScheme.inversePrimary
                                    color: Theme.of(context).colorScheme.inverseSurface.withOpacity(.2)
                                    .withOpacity(0.3), // Color de sombra
                                offset:
                                const Offset(0, 40), // Desplazamiento de sombra
                                blurRadius: 6, // Radio de difuminado
                                spreadRadius: 2, // Extensión de sombra
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/images/bg_placa.png',
                            width: 150,
                            height: 150,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(
                            context); // Regresar a la pantalla anterior
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.all(8),
                        width: 50,
                        height: 50,
                        child: const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    top: 30,
                    child: Center(
                      child: Text(
                        '${json["placa"]}',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                //color: Colors.white,
                color: Theme.of(context).colorScheme.background,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Tabla 1: Datos de Vehículo
                        _buildTable(context,'Datos de Vehículo', [
                          _buildTableRow('Placa', '${json["placa"]}'),
                          _buildTableRow('Marca', '${json["marca"]}'),
                          _buildTableRow('Modelo', '${json["modelo"]}'),
                          _buildTableRow('Color', '${json["color"]}'),
                          _buildTableRow('Motor', '${json["motor"]}'),
                          _buildTableRow('VIN', '${json["vin"]}'),
                        ],
                        color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1)),
                        const SizedBox(height: 20),
                        // Tabla 2: Datos de Financiera
                        _buildTable(
                          context,
                            'Datos de Financiera',
                            [
                              _buildTableRow('Nombre', '${json["financiera"]}'),
                              _buildTableRow('No. Préstamo', '${json["no_prestamo"]}'),
                              _buildTableRow('No. Perfil', 'ValorPerfil'),
                              _buildTableRow('Nombre Cliente', '${json["cliente"]}'),
                              _buildTableRow('Estado', '${json["estado"]}'),
                              _buildTableRow('Días de mora', '${json["dias_mora"]}'),
                              _buildTableRow('Monto Adeudado', '${json["montoadeudado"]}'),
                            ],
                            color: Theme.of(context).colorScheme.error.withOpacity(0.1)),
                        const SizedBox(height: 20),
                        // Icono de contacto y texto de contacto
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.contact_phone),
                            SizedBox(width: 10),
                            Text('Contacto: +504 27820036'),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTable(BuildContext context,String title, List<TableRow> rows, {Color? color}) {
    bool isEven = false;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          BoxShadow(
            //color: Theme.of(context).colorScheme.inversePrimary,
            color: Theme.of(context).colorScheme.inverseSurface.withOpacity(.2),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTableTitle(context,title),
          Table(
            border: TableBorder.symmetric(
              inside: const BorderSide(width: 1, color: Colors.transparent),
            ),
            children: rows.map((row) {
              isEven = !isEven;
              return TableRow(
                decoration: BoxDecoration(
                  color: isEven ? color ?? Theme.of(context).colorScheme.primary.withOpacity(0.2) : Theme.of(context).colorScheme.background,
                ),
                children: row.children,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTableTitle(BuildContext context, String title) {
    return Container(

      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String title, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(value), // Asigna el valor adecuado aquí
          ),
        ),
      ],
    );
  }
}
