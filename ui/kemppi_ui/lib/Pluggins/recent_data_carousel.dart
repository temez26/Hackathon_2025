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
        itemCount: 5, // Número de elementos en el carrusel
        itemBuilder: (context, index) {
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
                          "308 (avg)",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Proxima Nova',
                          ),
                        ),
                        SizedBox(width: 200),
                        Text(
                          "35 (avg)",
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
                          "15721 ms",
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
                          "00",
                        ),
                        SizedBox(width: 10),
                        Text(
                          "wire: ",
                        ),
                        Text(
                          "00",
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
                          "00",
                        ),
                        SizedBox(width: 10),
                        Text(
                          "gas: ",
                        ),
                        Text(
                          "00",
                        )
                      ],
                    ),
                    SizedBox(height: 15),

                    // Modelo
                    Center(
                      child: Text(
                        "Model: X8",
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
