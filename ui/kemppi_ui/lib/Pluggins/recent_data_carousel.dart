import 'package:flutter/material.dart';
import 'package:kemppi_ui/model/Machine.dart';

class RecentDataCarousel extends StatefulWidget {
  final List<Machine> list_machines;
  RecentDataCarousel({required this.list_machines});

  @override
  _RecentDataCarousel createState() => _RecentDataCarousel();
}

class _RecentDataCarousel extends State<RecentDataCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.6);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 800,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.list_machines.length,
        itemBuilder: (context, index) {
          final machine = widget.list_machines[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ClipRRect(
              child: Container(
                padding: const EdgeInsets.only(
                    left: 40, right: 40), // Espaciado interno
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Fondo gris claro
                  border: Border.all(color: Colors.orange, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Corriente y Voltaje
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Current:",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 200),
                        Text(
                          "Voltage:",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${machine.weldingParameters.current.avg} (avg)",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Proxima Nova',
                          ),
                        ),
                        SizedBox(width: 200),
                        Text(
                          "${machine.weldingParameters.voltage.avg} (avg)",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Proxima Nova',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          "Weld Duration Total: ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${machine.weldDurationMs.totalMs} ms",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Proxima Nova',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    // Consumo de materiales
                    Text(
                      "Material consumption:",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Proxima Nova'),
                    ),
                    Row(
                      children: [
                        Text(
                          "energy: ",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'Proxima Nova'),
                        ),
                        Text(
                          "${machine.materialConsumption.energyConsumptionAsWh} Wh",
                        ),
                        SizedBox(width: 10),
                        Text(
                          "wire: ",
                        ),
                        Text(
                          "${machine.materialConsumption.wireConsumptionInMeters} m",
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "filler: ",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'Proxima Nova'),
                        ),
                        Text(
                          "${machine.materialConsumption.fillerConsumptionInGrams} g",
                        ),
                        SizedBox(width: 10),
                        Text(
                          "gas: ",
                        ),
                        Text(
                          "${machine.materialConsumption.gasConsumptionInLiters} l",
                        )
                      ],
                    ),
                    SizedBox(height: 15),

                    // Modelo
                    Center(
                      child: Text(
                        "Model: ${machine.weldingMachine.model}",
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Proxima Nova'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
