import 'package:flutter/material.dart';

class RecentUsedMachines extends StatefulWidget {
  @override
  _RecentUsedMachines createState() => _RecentUsedMachines();
}

class _RecentUsedMachines extends State<RecentUsedMachines> {
  final PageController _controller = PageController(viewportFraction: 0.6);
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 5) {
      // Prevent going past the last item
      _currentPage++;
      _controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      // Prevent going before first item
      _currentPage--;
      _controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 1000,
      child: Stack(
        children: [
          // Carousel
          PageView.builder(
            controller: _controller,
            itemCount: 6,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300], // Fondo gris
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Rectángulo naranja
                        Container(
                          width: 300,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Model",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Left Button
          Positioned(
            left: 10,
            top: 150, // Adjust position vertically
            child: IconButton(
              icon: Icon(Icons.arrow_back, size: 40, color: Colors.black),
              onPressed: _previousPage,
            ),
          ),

          // Right Button
          Positioned(
            right: 10,
            top: 150, // Adjust position vertically
            child: IconButton(
              icon: Icon(Icons.arrow_forward, size: 40, color: Colors.black),
              onPressed: _nextPage,
            ),
          ),
        ],
      ),
    );
  }
}
