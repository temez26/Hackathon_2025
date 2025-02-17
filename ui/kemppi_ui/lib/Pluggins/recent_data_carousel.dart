import 'package:flutter/material.dart';

class RecentDataCarousel extends StatefulWidget {
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
      height: 250,
      width: 800,
      child: PageView.builder(
        controller: _controller,
        itemCount: 5, // Número de elementos en el carrusel
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(12), // Espaciado interno
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Fondo gris claro
                  border: Border.all(
                      color: Colors.orange, width: 2), // Borde naranja
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Alinear texto a la izquierda
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Corriente y Voltaje
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Current:\n308 (avg)",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        Text(
                          "Voltage:\n35 (avg)",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Duración de soldadura
                    Text(
                      "Weld Duration Total: 15721 ms",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    const SizedBox(height: 8),

                    // Consumo de materiales
                    Text(
                      "Material consumption:",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "energy: 47.08 Wh, wire: 1.31 m,\n"
                      "filler: 31.44 g, gas: 3.93 l",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    const SizedBox(height: 12),

                    // Modelo
                    Center(
                      child: Text(
                        "Model: X8",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
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
