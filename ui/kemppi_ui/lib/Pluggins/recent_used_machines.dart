import 'package:flutter/material.dart';

class RecentUsedMachines extends StatefulWidget {
  @override
  _RecentUsedMachines createState() => _RecentUsedMachines();
}

class _RecentUsedMachines extends State<RecentUsedMachines> {
  final PageController _controller = PageController(viewportFraction: 0.6);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 800,
      child: PageView.builder(
        controller: _controller,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Fondo gris
                  border: Border.all(
                      color: Color(0xFFf57300), width: 4), // Borde naranja
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Rectángulo naranja
                    Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.orange, // Color naranja
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(
                        height: 8), // Espacio entre el rectángulo y el texto
                    // Texto debajo del rectángulo
                    const Text(
                      "Model",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
