import 'package:flutter/material.dart';
import 'package:kemppi_ui/model/Machine.dart';

class MachinedetailPopup extends StatelessWidget {
  final Machine machine;

  MachinedetailPopup({required this.machine});

  void showWeldingPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: Container(
            width: 500,
            height: 530,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      color: Colors.white,
                      icon: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.close, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      iconSize: 40,
                    ),
                  ),
                  // Título en naranja
                  Text(
                    machine.weldingMachine.model,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Proxima Nova',
                      color: Color(0xFFf57300),
                    ),
                  ),
                  SizedBox(height: 12),

                  // Información general
                  buildInfoRow("Serial:", machine.weldingMachine.serial),
                  buildInfoRow("Name:", machine.weldingMachine.name),
                  buildInfoRow("Group:", machine.weldingMachine.group),

                  SizedBox(height: 10),

                  // Información de voltaje y corriente
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildInfoColumn("Current:",
                          "'308' (avg), 274 (min), 342 (max)"), //WE NEED A NEW CALL TO THE SERVER TO GET THE AVG FROM THE SPECIFIC MACHINE
                      buildInfoColumn(
                          "Voltage:", "35 (avg), 30 (min), 41 (max)"),
                    ],
                  ),

                  SizedBox(height: 10),

                  // Duración de la soldadura
                  Text("Weld Duration:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Proxima Nova',
                          fontSize: 18)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildWeldDurationRow("preWeld:", "2990 ms"),
                          buildWeldDurationRow("weld:", "7862 ms"),
                        ],
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildWeldDurationRow("postWeld:", "4869 ms"),
                          buildWeldDurationRow("Total:", "15721 ms"),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  // Consumo de materiales
                  Text("Material Consumption:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Proxima Nova',
                          fontSize: 18)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildMaterialConsumptionRow("Energy:", "47.08 Wh"),
                          buildMaterialConsumptionRow("Wire:", "1.31 m"),
                        ],
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildMaterialConsumptionRow("Filler:", "31.44 g"),
                          buildMaterialConsumptionRow("Gas:", "3.93 l"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget para mostrar una fila con dos textos
  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Proxima Nova',
                  fontSize: 20)),
          SizedBox(width: 5),
          Text(value,
              style: TextStyle(fontFamily: 'Proxima Nova', fontSize: 20)),
        ],
      ),
    );
  }

  // Widget para una columna con título y valor
  Widget buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Proxima Nova',
                fontSize: 18)),
        Text(value, style: TextStyle(fontFamily: 'Proxima Nova', fontSize: 16)),
      ],
    );
  }

  // Widget para una fila con consumo de materiales
  Widget buildMaterialConsumptionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(label,
              style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Proxima Nova',
                  fontSize: 16)),
          SizedBox(width: 5),
          Text(value,
              style: TextStyle(fontFamily: 'Proxima Nova', fontSize: 16)),
        ],
      ),
    );
  }

  // Widget para una fila con duración de soldadura
  Widget buildWeldDurationRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(label,
              style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Proxima Nova',
                  fontSize: 16)),
          SizedBox(width: 5),
          Text(value,
              style: TextStyle(fontFamily: 'Proxima Nova', fontSize: 16)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welding Machines")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => showWeldingPopup(context),
          child: Text("Show Welding Info"),
        ),
      ),
    );
  }
}
